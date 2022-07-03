const { generateText, createElement, validateInput } = require('../util.js');

/*test ('Salida de Nombre y Edad', () =>{
    const test = generateText ('Daniel', 30);
    expect (text).toBe('Daniel (30 years old');
});*/

test('Prueba 1', ()=> {
    const prueba = generateText("Daniela", 28)
    expect(prueba).toBe('Daniela (31 years old)');
})
