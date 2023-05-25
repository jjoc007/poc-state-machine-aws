import { ProcessData } from './domain/services/processData';
import {IProcessData} from "./domain/ports/core/IProcessData";
import {ICamara} from "./domain/ports/client/ICamara";
import {CamaraClient} from "./infrastructure/client/CamaraClient";

export function createProcessData(): IProcessData {
    return new ProcessData(createCamaraClient());
}

export function createCamaraClient(): ICamara {
    return new CamaraClient();
}
