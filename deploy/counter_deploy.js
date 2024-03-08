"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const signer_1 = require("@taquito/signer");
const taquito_1 = require("@taquito/taquito");
const counter_mligo_json_1 = __importDefault(require("../compiled/counter.mligo.json"));
const RPC_ENDPOINT = "https://ghostnet.tezos.marigold.dev";
function main() {
    return __awaiter(this, void 0, void 0, function* () {
        const Tezos = new taquito_1.TezosToolkit(RPC_ENDPOINT);
        //set alice key
        Tezos.setProvider({
            signer: yield signer_1.InMemorySigner.fromSecretKey("edskRx1GMHPmi7cyQ71jbDaF2SvBNR1EQ2nd18dqwjNKcrBT4vryWY6A1N5z6bcWcQ93N1Ejw6m6V3QKFRuCavYAxvsgweA8Nq"),
        });
        const initialStorage = {
            admin: "tz1TiFzFCcwjv4pyYGTrnncqgq17p59CzAE2",
            value: "42"
        };
        try {
            const originated = yield Tezos.contract.originate({
                code: counter_mligo_json_1.default,
                storage: initialStorage,
            });
            console.log(`Waiting for myContract ${originated.contractAddress} to be confirmed...`);
            yield originated.confirmation(2);
            console.log("confirmed contract: ", originated.contractAddress);
        }
        catch (error) {
            console.log(error);
        }
    });
}
main();
