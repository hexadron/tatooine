# Pruebas

Para ejectuar los tests, desde la consola dentro de la carpeta del proyecto se ejecutan el siguiente commando:

    rspec

Se ejecutarán los tests. Los resultados que se obtendrán tendrán un formato similar a este:

    ....**..........**.....**

    [lista de archivos ejecutados]

    Finished in 14.59 seconds
    25 examples, 0 failures, 6 pending

Los puntos representan tests realizados satisfactoriamente, los asteriscos tests especificados pero no implementados, y las F representan tests que han mostrado errores en su ejecución.

Si sólo se quiere ejecutar un test específico, el de User por ejemplo, se especificará el nombre del archivo en el comando:

    rspec spec/models/user_spec.rb

Donde obtendremos un resultado similar a este:
    
    ....

    Finished in 0.18318 seconds
    4 examples, 0 failures

Luego de ejecutar las pruebas, se puede abrir el archivo `index.html` dentro de la carpeta `coverage` (este archivo se autogenera después de cada ejecución de pruebas) para ver información adicional relacionada al ratio de código:pruebas.
