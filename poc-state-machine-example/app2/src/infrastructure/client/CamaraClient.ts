import {ICamara} from "../../domain/ports/client/ICamara";

export class CamaraClient implements ICamara {
    getData(identificationType: string, identificationNumber: string): string {
        console.log(`identificationType: ${identificationType} identificationNumber: ${identificationNumber} from client`)
        return `mi tipo es: ${identificationType} mi numero: ${identificationNumber}`;
    }
}
