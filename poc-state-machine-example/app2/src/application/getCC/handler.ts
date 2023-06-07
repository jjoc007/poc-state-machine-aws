import 'source-map-support/register';

import { createProcessData } from '../../dependencies';

export const handler = async (event: any) => {
    const processData = createProcessData();
    const { step, data } = event;
    return processData.processData(step, data);
};
