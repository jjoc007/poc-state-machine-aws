const WebSocket = require('ws');
const socket = new WebSocket('wss://5qao8tjq2l.execute-api.us-east-1.amazonaws.com/dev');

socket.addEventListener('open', (event) => {
    console.log('Conexión WebSocket abierta:', event);
});

socket.addEventListener('message', (event) => {
    const data = JSON.parse(event.data);
    console.log('ID de conexión:', data.connectionId);
});

socket.addEventListener('error', (event) => {
    console.log('Error en WebSocket:', event);
});

socket.addEventListener('close', (event) => {
    console.log('Conexión WebSocket cerrada:', event);
});
