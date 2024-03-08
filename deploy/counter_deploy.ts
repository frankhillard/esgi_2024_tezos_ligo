import { InMemorySigner } from "@taquito/signer";
import { MichelsonMap, TezosToolkit } from "@taquito/taquito";
import { char2Bytes } from "@taquito/utils";

import Counter from "../compiled/counter.mligo.json";

const RPC_ENDPOINT = "https://ghostnet.tezos.marigold.dev";

async function main() {
  const Tezos = new TezosToolkit(RPC_ENDPOINT);

  //set alice key
  Tezos.setProvider({
    signer: await InMemorySigner.fromSecretKey(
      "edskRx1GMHPmi7cyQ71jbDaF2SvBNR1EQ2nd18dqwjNKcrBT4vryWY6A1N5z6bcWcQ93N1Ejw6m6V3QKFRuCavYAxvsgweA8Nq"
    ),
  });

  const initialStorage = {
    admin : "tz1TiFzFCcwjv4pyYGTrnncqgq17p59CzAE2",
    value : "42" 
  };

  try {
    const originated = await Tezos.contract.originate({
      code: Counter,
      storage: initialStorage,
    });
    console.log(
      `Waiting for myContract ${originated.contractAddress} to be confirmed...`
    );
    await originated.confirmation(2);
    console.log("confirmed contract: ", originated.contractAddress);
  } catch (error: any) {
    console.log(error);
  }
}

main();