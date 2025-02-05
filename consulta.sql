
CREATE TABLE categorias (
    categoriaid INT PRIMARY KEY,
    NombreCategoria VARCHAR(25),
    Descripcion VARCHAR(50)
);

CREATE TABLE sucursales (
    sucursalid INT PRIMARY KEY,
    NombreSucursal VARCHAR(25),
    Direccion VARCHAR(50)
);


CREATE TABLE productos (
    productoId INT PRIMARY KEY,
    nombre VARCHAR(25),
    categoriaId INT,
    Precio DECIMAL(4, 2),
    sucursalid INT,
    FOREIGN KEY (categoriaId) REFERENCES categorias(categoriaid),
    FOREIGN KEY (sucursalid) REFERENCES sucursales(sucursalid)
);



INSERT INTO categorias (categoriaid, NombreCategoria, Descripcion)
VALUES 
(1, 'Juguetes', 'Juguetes para niños'),
(2, 'Ropa', 'Ropa para todas las edades'),
(3, 'Electrónica', 'Artículos electrónicos');


INSERT INTO sucursales (sucursalid, NombreSucursal, Direccion)
VALUES 
(1, 'Sucursal Centro', '5 Norte 144, Colonia Centro'),
(2, 'Sucursal Héroes', 'Héroes de la Independencia 509, Colonia Centro');


INSERT INTO productos (productoId, nombre, categoriaId, Precio, sucursalid)
VALUES 
(1, 'Peluche Capibara', 1, 299.99, 1),
(2, 'Camiseta', 2, 149.50, 2),
(3, 'Audífonos', 3, 899.99, 1);




SELECT * FROM categorias;


SELECT * FROM sucursales;







!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listar Datos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #ffe6f2;
        }
        .container {
            max-width: 900px;
            background-color: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        h1, h3 {
            color: #cc0099;
        }
        table {
            width: 100%;
            margin-bottom: 20px;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f7c6f7;
        }
        .btn {
            background-color: #cc66cc;
            border: none;
        }
        .btn:hover {
            background-color: #b347b3;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Listar Datos</h1>

        <h3>Categorías</h3>
        <table id="tablaCategorias">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>

        
        <h3>Sucursales</h3>
        <table id="tablaSucursales">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Dirección</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>

        <h3>Productos</h3>
        <table id="tablaProductos">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Categoría</th>
                    <th>Precio</th>
                    <th>Sucursal</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>

        <div class="text-center mt-4">
            <a href="registrar.html" class="btn text-white">Ir a Registrar</a>
        </div>
    </div>

    <script>
      
        function eliminarElemento(tipo, id) {
            let datos = JSON.parse(localStorage.getItem(tipo)) || [];
            datos = datos.filter(item => item.categoriaid !== id && item.sucursalid !== id && item.productoId !== id); // Filtramos el ID a eliminar
            localStorage.setItem(tipo, JSON.stringify(datos));
            cargarDatos(); 
        }


        function cargarDatos() {
            const categorias = JSON.parse(localStorage.getItem("categorias")) || [];
            const sucursales = JSON.parse(localStorage.getItem("sucursales")) || [];
            const productos = JSON.parse(localStorage.getItem("productos")) || [];

            const tablaCategorias = document.getElementById("tablaCategorias").querySelector("tbody");
            const tablaSucursales = document.getElementById("tablaSucursales").querySelector("tbody");
            const tablaProductos = document.getElementById("tablaProductos").querySelector("tbody");

            tablaCategorias.innerHTML = "";
            categorias.forEach(cat => {
                const fila = `<tr>
                    <td>${cat.categoriaid}</td>
                    <td>${cat.nombre}</td>
                    <td>${cat.descripcion}</td>
                    <td><button class="btn text-white" onclick="eliminarElemento('categorias', ${cat.categoriaid})">Eliminar</button></td>
                </tr>`;
                tablaCategorias.innerHTML += fila;
            });

            tablaSucursales.innerHTML = "";
            sucursales.forEach(suc => {
                const fila = `<tr>
                    <td>${suc.sucursalid}</td>
                    <td>${suc.nombre}</td>
                    <td>${suc.direccion}</td>
                    <td><button class="btn text-white" onclick="eliminarElemento('sucursales', ${suc.sucursalid})">Eliminar</button></td>
                </tr>`;
                tablaSucursales.innerHTML += fila;
            });

            tablaProductos.innerHTML = "";
            productos.forEach(prod => {
                const categoria = categorias.find(c => c.categoriaid == prod.categoriaId);
                const sucursal = sucursales.find(s => s.sucursalid == prod.sucursalid);
                const fila = `<tr>
                    <td>${prod.productoId}</td>
                    <td>${prod.nombre}</td>
                    <td>${categoria ? categoria.nombre : "Sin categoría"}</td>
                    <td>$${prod.precio}</td>
                    <td>${sucursal ? sucursal.nombre : "Sin sucursal"}</td>
                    <td><button class="btn text-white" onclick="eliminarElemento('productos', ${prod.productoId})">Eliminar</button></td>
                </tr>`;
                tablaProductos.innerHTML += fila;
            });
        }

        cargarDatos();
    </script>
</body>
</html>























<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Datos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #ffe6f2;
        }
        .container {
            max-width: 700px;
            background-color: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        h1, h3 {
            color: #cc0099;
        }
        .btn {
            background-color: #cc66cc;
            border: none;
        }
        .btn:hover {
            background-color: #b347b3;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Registrar Datos</h1>

        <h3>Categorías</h3>
        <form id="formCategoria">
            <input type="number" id="categoriaId" class="form-control mb-2" placeholder="ID de la Categoría" required>
            <input type="text" id="categoriaNombre" class="form-control mb-2" placeholder="Nombre de la Categoría" required>
            <input type="text" id="categoriaDescripcion" class="form-control mb-2" placeholder="Descripción" required>
            <button type="submit" class="btn text-white w-100">Agregar Categoría</button>
        </form>

        <h3>Sucursales</h3>
        <form id="formSucursal">
            <input type="number" id="sucursalId" class="form-control mb-2" placeholder="ID de la Sucursal" required>
            <input type="text" id="sucursalNombre" class="form-control mb-2" placeholder="Nombre de la Sucursal" required>
            <input type="text" id="sucursalDireccion" class="form-control mb-2" placeholder="Dirección" required>
            <button type="submit" class="btn text-white w-100">Agregar Sucursal</button>
        </form>

        <h3>Productos</h3>
        <form id="formProducto">
            <input type="number" id="productoId" class="form-control mb-2" placeholder="ID del Producto" required>
            <input type="text" id="productoNombre" class="form-control mb-2" placeholder="Nombre del Producto" required>
            <select id="productoCategoria" class="form-control mb-2" required>
                <option value="">Seleccionar Categoría</option>
            </select>
            <input type="number" id="productoPrecio" class="form-control mb-2" placeholder="Precio" step="0.01" required>
            <select id="productoSucursal" class="form-control mb-2" required>
                <option value="">Seleccionar Sucursal</option>
            </select>
            <button type="submit" class="btn text-white w-100">Agregar Producto</button>
        </form>

        <div class="text-center mt-4">
            <a href="listar.html" class="btn text-white">Ir a Listar</a>
        </div>
    </div>

    <script>
        function guardarEnLocalStorage(clave, valor) {
            const datos = JSON.parse(localStorage.getItem(clave)) || [];
            datos.push(valor);
            localStorage.setItem(clave, JSON.stringify(datos));
        }

        function actualizarOpciones() {
            const categorias = JSON.parse(localStorage.getItem("categorias")) || [];
            const sucursales = JSON.parse(localStorage.getItem("sucursales")) || [];
            const categoriaSelect = document.getElementById("productoCategoria");
            const sucursalSelect = document.getElementById("productoSucursal");

            categoriaSelect.innerHTML = '<option value="">Seleccionar Categoría</option>';
            sucursalSelect.innerHTML = '<option value="">Seleccionar Sucursal</option>';

            categorias.forEach(cat => {
                const option = document.createElement("option");
                option.value = cat.categoriaid;
                option.textContent = `${cat.categoriaid} - ${cat.nombre}`;
                categoriaSelect.appendChild(option);
            });

            sucursales.forEach(suc => {
                const option = document.createElement("option");
                option.value = suc.sucursalid;
                option.textContent = `${suc.sucursalid} - ${suc.nombre}`;
                sucursalSelect.appendChild(option);
            });
        }

        document.getElementById("formCategoria").addEventListener("submit", (e) => {
            e.preventDefault();
            const id = document.getElementById("categoriaId").value;
            const nombre = document.getElementById("categoriaNombre").value;
            const descripcion = document.getElementById("categoriaDescripcion").value;
            guardarEnLocalStorage("categorias", { categoriaid: id, nombre, descripcion });
            e.target.reset();
            actualizarOpciones();
            alert("Categoría registrada.");
        });

        document.getElementById("formSucursal").addEventListener("submit", (e) => {
            e.preventDefault();
            const id = document.getElementById("sucursalId").value;
            const nombre = document.getElementById("sucursalNombre").value;
            const direccion = document.getElementById("sucursalDireccion").value;
            guardarEnLocalStorage("sucursales", { sucursalid: id, nombre, direccion });
            e.target.reset();
            actualizarOpciones();
            alert("Sucursal registrada.");
        });

        document.getElementById("formProducto").addEventListener("submit", (e) => {
            e.preventDefault();
            const id = document.getElementById("productoId").value;
            const nombre = document.getElementById("productoNombre").value;
            const categoriaId = document.getElementById("productoCategoria").value;
            const precio = document.getElementById("productoPrecio").value;
            const sucursalid = document.getElementById("productoSucursal").value;

            if (!categoriaId || !sucursalid) {
                alert("Debes seleccionar una categoría y una sucursal.");
                return;
            }

            guardarEnLocalStorage("productos", { productoId: id, nombre, categoriaId, precio, sucursalid });
            e.target.reset();
            alert("Producto registrado.");
        });

        actualizarOpciones();
    </script>
</body>
</html>
