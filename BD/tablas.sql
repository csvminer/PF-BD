CREATE TABLE Persona (
    id_per VARCHAR(13) PRIMARY KEY,
    nombre_per VARCHAR(18),
    ape1_per VARCHAR(18),
    ape2_per VARCHAR(18),
    correo_per VARCHAR(50),
    telefono_per VARCHAR(10),
    gen_per VARCHAR(18)
);

CREATE TABLE Direccion (
    id_direccion SERIAL PRIMARY KEY,
    direccion VARCHAR(200)
);


CREATE TABLE Cargo (
    id_cargo SERIAL PRIMARY KEY,
    descripcion_cargo VARCHAR(200)
);

CREATE TABLE Tipo_Pago (
    id_tp SERIAL PRIMARY KEY,
    descripcion_tp VARCHAR(200)
);

CREATE TABLE Estado_Des (
    id_ed SERIAL PRIMARY KEY,
    descripcion_ed VARCHAR(200)
);

CREATE TABLE Modelo (
    id_modelo SERIAL PRIMARY KEY,
    marca VARCHAR(20),
    modelo VARCHAR(20),
    anio INTEGER
);

CREATE TABLE Categoria (
    id_cat SERIAL PRIMARY KEY,
    descripcion_cat VARCHAR(200)
);

CREATE TABLE Persona_Dir (
    id_per_dir SERIAL PRIMARY KEY,
    id_per VARCHAR(13),
    id_dir INTEGER,
    FOREIGN KEY (id_per) REFERENCES Persona (id_per) ON DELETE CASCADE,
    FOREIGN KEY (id_dir) REFERENCES Direccion (id_direccion) ON DELETE CASCADE
);

CREATE TABLE Cliente (
    id_cliente SERIAL PRIMARY KEY,
    id_per VARCHAR(13),
    fecha_regitro_cli DATE,
    estado_cli VARCHAR(13),
    FOREIGN KEY (id_per) REFERENCES Persona (id_per) ON DELETE CASCADE
);

CREATE TABLE Proveedor(
    id_proveedor VARCHAR(13) PRIMARY KEY,
    nombre_prov VARCHAR(80),
    direccion_prov VARCHAR(100),
    correo_prov VARCHAR(100),
    telefono_prov VARCHAR(10),
    estado_prov VARCHAR(80),
    FOREIGN KEY (id_proveedor) REFERENCES Persona (id_per)
);

CREATE TABLE Empleado (
    id_emp VARCHAR(13) PRIMARY KEY,
    id_cargo INTEGER,
    fecha_con_emp DATE,
    sueldo NUMERIC(10, 2),
    FOREIGN KEY (id_emp) REFERENCES Persona (id_per) ON DELETE CASCADE,
    FOREIGN KEY (id_cargo) REFERENCES Cargo (id_cargo) ON DELETE CASCADE
);

CREATE TABLE Bodega (
    id_bodega SERIAL PRIMARY KEY,
    capacidad_bodega NUMERIC(10, 2),
    estado_dodega VARCHAR(20),
    id_emp VARCHAR (13),
    FOREIGN KEY (id_emp) REFERENCES Empleado (id_emp) ON DELETE CASCADE
);

CREATE TABLE Fac_Compra (
    id_fac_compra SERIAL PRIMARY KEY,
    id_proveedor VARCHAR(13),
    id_tipo_pago INTEGER,
    fecha_compra DATE,
    total_compra NUMERIC(10, 2),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor (id_proveedor) ON DELETE CASCADE,
    FOREIGN KEY (id_tipo_pago) REFERENCES Tipo_Pago (id_tp) ON DELETE CASCADE
);

CREATE TABLE Producto (
    id_pro SERIAL PRIMARY KEY,
    id_categoria INTEGER,
    nombre_pro VARCHAR(100),
    descripcion_pro VARCHAR(200),
    stock_min_pro INTEGER,
    stock_max_pro INTEGER,
    stock_pro INTEGER,
    precio_pro NUMERIC(10, 2),
    FOREIGN KEY (id_categoria) REFERENCES Categoria (id_cat) ON DELETE CASCADE
);

CREATE TABLE Detalle_Compra (
    id_det_compra SERIAL PRIMARY KEY,
    id_producto INTEGER,
    id_fac_compra INTEGER,
    cantidad_compra INTEGER,
    precio_unitario_compra NUMERIC(10, 2),
    FOREIGN KEY (id_producto) REFERENCES Producto (id_pro) ON DELETE CASCADE,
    FOREIGN KEY (id_fac_compra) REFERENCES Fac_Compra (id_fac_compra) ON DELETE CASCADE
);

CREATE TABLE Factura (
    id_factura SERIAL PRIMARY KEY,
    id_cliente INTEGER,
    id_tipo_pago INTEGER,
    fecha_factura DATE,
    total NUMERIC(10,2),
    FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_tipo_pago) REFERENCES Tipo_Pago (id_tp) ON DELETE CASCADE
);

CREATE TABLE Detalle_Fact (
    id_det SERIAL PRIMARY KEY,
    id_producto INTEGER,
    id_factura INTEGER,
    iva_det NUMERIC(3, 2) CHECK (iva_det >= 0 AND iva_det <= 1),
    descuento_det NUMERIC(3, 2) CHECK (descuento_det >= 0 AND descuento_det <= 1),
    cantidad_det INTEGER,
    precio_unitario_det NUMERIC(10, 2),
    FOREIGN KEY (id_producto) REFERENCES Producto (id_pro) ON DELETE CASCADE,
    FOREIGN KEY (id_factura) REFERENCES Factura (id_factura) ON DELETE CASCADE
);

CREATE TABLE Vehiculo (
    placa_vehi VARCHAR(10) PRIMARY KEY,
    id_modelo INTEGER,
    capacidad_vehi NUMERIC(10, 2),
    deleted_vehi BOOLEAN,
    fecha_adquisicion_vehi DATE,
    FOREIGN KEY (id_modelo) REFERENCES Modelo (id_modelo) ON DELETE CASCADE
);

CREATE TABLE Despacho (
    id_despacho INTEGER PRIMARY KEY,
    id_estado INTEGER,
    placa_vehi VARCHAR(10),
    id_factura INTEGER,
    fecha_despacho DATE,
    direccion_despacho VARCHAR(100),
    FOREIGN KEY (id_estado) REFERENCES Estado_Des (id_ed) ON DELETE CASCADE,
    FOREIGN KEY (placa_vehi) REFERENCES Vehiculo (placa_vehi) ON DELETE CASCADE,
    FOREIGN KEY (id_factura) REFERENCES Factura (id_factura) ON DELETE CASCADE
);


CREATE TABLE Vehi_Empleado (
    id_vehi_empleado SERIAL PRIMARY KEY,
    id_empleado VARCHAR(13),
    placa_vehi VARCHAR(10),
    fecha_uso_vehi DATE,
    FOREIGN KEY (id_empleado) REFERENCES Empleado (id_emp) ON DELETE CASCADE,
    FOREIGN KEY (placa_vehi) REFERENCES Vehiculo (placa_vehi) ON DELETE CASCADE
);