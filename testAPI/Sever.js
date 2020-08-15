const expess = require('express');
const app = expess();

const port = 3000;

app.listen(port, () => {
    console.log('abc' + port)
})