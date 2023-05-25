import { IProcessData } from "../ports/core/IProcessData";
import {ICamara} from "../ports/client/ICamara";

export class ProcessData implements IProcessData {

    private camaraClient: ICamara;

    constructor(camaraClient: ICamara) { // Inicializa el atributo en el constructor
        this.camaraClient = camaraClient;
    }

    processData(step: string, data: string): void {
        console.log(`Step: ${step} Data: ${data} from service`)
        const {identification_type, identification_number} = JSON.parse(data);
        this.camaraClient.getData(identification_type, identification_number);
    }
}
