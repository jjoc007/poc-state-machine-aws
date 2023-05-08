const AWS = require('aws-sdk');

const ddb = new AWS.DynamoDB.DocumentClient({ apiVersion: '2012-08-10', region: process.env.AWS_REGION });


exports.handler = async event => {
    const putParams = {
        TableName: process.env.TABLE_WEB_SOCKET_NAME,
        Item: {
            connectionId: event.requestContext.connectionId
        }
    };

    const apiGatewayManagementApi = new AWS.ApiGatewayManagementApi({
        apiVersion: '2018-11-29',
        endpoint: '5qao8tjq2l.execute-api.us-east-1.amazonaws.com/dev'
    });

    try {
        await ddb.put(putParams).promise();
    } catch (err) {
        return { statusCode: 500, body: 'Failed to connect: ' + JSON.stringify(err) };
    }

    const initialMessage = JSON.stringify({
        message: "Connected",
        connectionID : event.requestContext.connectionId
    });

    return { statusCode: 200, body: "bien" };
};
