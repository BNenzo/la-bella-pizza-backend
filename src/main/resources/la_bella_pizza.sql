USE la_bella_pizza;

DROP TABLE IF EXISTS clicks_contenidos;
DROP TABLE IF EXISTS contenidos;
DROP TABLE IF EXISTS especialidades_alimentarias_sucursales;
DROP TABLE IF EXISTS especialidades_alimentarias;
DROP TABLE IF EXISTS tipos_comidas_sucursales;
DROP TABLE IF EXISTS tipos_comidas;
DROP TABLE IF EXISTS estilos_sucursales;
DROP TABLE IF EXISTS estilos;
DROP TABLE IF EXISTS reservas_sucursales;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS zonas_turnos_sucursales;
DROP TABLE IF EXISTS turnos_sucursales;
DROP TABLE IF EXISTS zonas_sucursales;
DROP TABLE IF EXISTS zonas;
DROP TABLE IF EXISTS sucursales;
DROP TABLE IF EXISTS restaurantes;
DROP TABLE IF EXISTS categorias_precios;
DROP TABLE IF EXISTS localidades;
DROP TABLE IF EXISTS provincias;

CREATE TABLE provincias (
    cod_provincia CHAR(5) PRIMARY KEY,
    nom_provincia VARCHAR(100) NOT NULL
);

INSERT INTO provincias (cod_provincia, nom_provincia) VALUES
('BSAS','Buenos Aires'),
('CAT','Catamarca'),
('CHA','Chaco'),
('CHU','Chubut'),
('CBA','Córdoba'),
('COR','Corrientes'),
('ER','Entre Ríos'),
('FOR','Formosa'),
('JUJ','Jujuy'),
('LP','La Pampa'),
('LR','La Rioja'),
('MEN','Mendoza'),
('MIS','Misiones'),
('NEU','Neuquén'),
('RN','Río Negro'),
('SAL','Salta'),
('SJ','San Juan'),
('SL','San Luis'),
('SC','Santa Cruz'),
('SF','Santa Fe'),
('SE','Santiago del Estero'),
('TF','Tierra del Fuego'),
('TUC','Tucumán'),
('CABA','Ciudad Autónoma de Buenos Aires');

CREATE TABLE localidades (
    nro_localidad INT PRIMARY KEY,
    nom_localidad VARCHAR(100) NOT NULL,
    cod_provincia CHAR(5) NOT NULL,
    FOREIGN KEY (cod_provincia) REFERENCES provincias(cod_provincia)
);

INSERT INTO localidades (nro_localidad, nom_localidad, cod_provincia) VALUES
(1,'Córdoba Capital','CBA'),(2,'Villa Carlos Paz','CBA'),(3,'Río Cuarto','CBA'),
(4,'Villa María','CBA'),(5,'Alta Gracia','CBA'),(6,'Jesús María','CBA'),
(7,'La Falda','CBA'),(8,'Cosquín','CBA'),(9,'Río Tercero','CBA'),(10,'San Francisco','CBA');

CREATE TABLE categorias_precios (
    nro_categoria INT PRIMARY KEY,
    nom_categoria VARCHAR(50) NOT NULL
);

INSERT INTO categorias_precios VALUES
(1, 'Económico'), (2, 'Moderado'), (3, 'Premium'), (4, 'Lujo');

CREATE TABLE restaurantes (
    nro_restaurante INT PRIMARY KEY,
    razon_social VARCHAR(150) NOT NULL,
    cuit CHAR(11) UNIQUE NOT NULL
);

INSERT INTO restaurantes VALUES (1, 'La Bella Pizza', '30714567891');

CREATE TABLE sucursales (
    nro_restaurante INT NOT NULL,
    nro_sucursal INT NOT NULL,
    nom_sucursal VARCHAR(100) NOT NULL,
    calle VARCHAR(100) NOT NULL,
    nro_calle INT,
    barrio VARCHAR(100),
    nro_localidad INT NOT NULL,
    cod_postal VARCHAR(10),
    telefonos VARCHAR(50),
    total_comensales INT,
    min_tolerancia_reserva INT,
    nro_categoria INT NOT NULL,
    PRIMARY KEY (nro_restaurante, nro_sucursal),
    FOREIGN KEY (nro_restaurante) REFERENCES restaurantes(nro_restaurante),
    FOREIGN KEY (nro_localidad) REFERENCES localidades(nro_localidad),
    FOREIGN KEY (nro_categoria) REFERENCES categorias_precios(nro_categoria)
);

INSERT INTO sucursales VALUES
(1,1,'Sucursal Alta Córdoba','Av. Colón',850,'Alta Córdoba',1,'5000','351-4567890',120,10,2),
(1,2,'Sucursal General Paz','Av. Hipólito Yrigoyen',350,'General Paz',1,'5000','351-4781234',80,15,3);

CREATE TABLE zonas (
    cod_zona CHAR(5) PRIMARY KEY,
    nom_zona VARCHAR(100) NOT NULL
);

INSERT INTO zonas (cod_zona, nom_zona) VALUES
('CTR','Centro'),
('NCBA','Nueva Córdoba'),
('ACBA','Alta Córdoba'),
('GPZ','General Paz'),
('CDLR','Cerro de las Rosas'),
('VBEL','Villa Belgrano');


CREATE TABLE zonas_sucursales (
    nro_restaurante INT NOT NULL,
    nro_sucursal INT NOT NULL,
    cod_zona CHAR(5) NOT NULL,
    cant_comensales INT NOT NULL,
    permite_menores INT NOT NULL,
    habilitada INT NOT NULL,
    PRIMARY KEY (nro_restaurante, nro_sucursal, cod_zona),
    FOREIGN KEY (nro_restaurante, nro_sucursal)
        REFERENCES sucursales (nro_restaurante, nro_sucursal),
    FOREIGN KEY (cod_zona) REFERENCES zonas (cod_zona)
);

INSERT INTO zonas_sucursales VALUES (1,1,'ACBA',20,1,1),(1,2,'GPZ',20,1,1);

CREATE TABLE turnos_sucursales (
    nro_restaurante INT NOT NULL,
    nro_sucursal INT NOT NULL,
    hora_desde TIME NOT NULL,
    hora_hasta TIME NOT NULL,
    habilitado INT NOT NULL,
    PRIMARY KEY (nro_restaurante, nro_sucursal, hora_desde),
    FOREIGN KEY (nro_restaurante, nro_sucursal)
        REFERENCES sucursales (nro_restaurante, nro_sucursal)
);

INSERT INTO turnos_sucursales VALUES
(1,1,'12:00','15:30',1),(1,1,'20:00','23:30',1),
(1,2,'12:00','15:00',1),(1,2,'20:00','23:00',0);

CREATE TABLE zonas_turnos_sucursales (
    nro_restaurante INT NOT NULL,
    nro_sucursal INT NOT NULL,
    hora_desde TIME NOT NULL,
    cod_zona CHAR(5) NOT NULL,
    permite_menores INT NOT NULL DEFAULT 1,
    -- PK en el MISMO orden que usa la FK
    PRIMARY KEY (nro_restaurante, nro_sucursal, cod_zona, hora_desde),
    FOREIGN KEY (nro_restaurante, nro_sucursal, hora_desde)
        REFERENCES turnos_sucursales (nro_restaurante, nro_sucursal, hora_desde),
    FOREIGN KEY (cod_zona) REFERENCES zonas (cod_zona)
);

INSERT INTO zonas_turnos_sucursales VALUES
(1,1,'12:00','ACBA',1),(1,1,'20:00','ACBA',0),
(1,2,'12:00','GPZ',1),(1,2,'20:00','GPZ',1);

CREATE TABLE clientes (
    nro_cliente INT PRIMARY KEY,
    apellido VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(150) UNIQUE NOT NULL,
    telefonos VARCHAR(50)
);

INSERT INTO clientes VALUES
(1,'Pérez','Juan','juan.perez@example.com','351-1234567'),
(2,'Gómez','María','maria.gomez@example.com','351-2345678'),
(3,'Rodríguez','Lucas','lucas.rodriguez@example.com','351-3456789'),
(4,'Fernández','Ana','ana.fernandez@example.com','351-4567890'),
(5,'Díaz','Carla','carla.diaz@example.com','351-5678901');

CREATE TABLE reservas_sucursales (
    cod_reserva VARCHAR(50) PRIMARY KEY,
    fecha_hora_registro DATETIME NOT NULL,
    nro_cliente INT NOT NULL,
    fecha_reserva DATE NOT NULL,
    nro_restaurante INT NOT NULL,
    nro_sucursal INT NOT NULL,
    cod_zona CHAR(5) NOT NULL,
    hora_reserva TIME NOT NULL,
    cant_adultos INT NOT NULL,
    cant_menores INT DEFAULT 0,
    costo_reserva DECIMAL(10,2) NOT NULL,
    cancelada INT DEFAULT 0,
    fecha_cancelacion DATE,
    FOREIGN KEY (nro_cliente) REFERENCES clientes (nro_cliente),
    FOREIGN KEY (nro_restaurante, nro_sucursal, cod_zona, hora_reserva)
        REFERENCES zonas_turnos_sucursales (nro_restaurante, nro_sucursal, cod_zona, hora_desde)
);

INSERT INTO reservas_sucursales VALUES
('LBP-001-R001','2025-11-02 18:30:00',1,'2025-11-05',1,1,'ACBA','12:00',2,0,12000.00,0,NULL),
('LBP-001-R002','2025-11-02 18:45:00',2,'2025-11-05',1,1,'ACBA','20:00',4,2,18000.00,0,NULL);

CREATE TABLE estilos (
    nro_estilo INT PRIMARY KEY,
    nom_estilo VARCHAR(100) NOT NULL
);

INSERT INTO estilos VALUES
(1,'Parrilla'),(2,'Italiana'),(3,'Vegetariana / Vegana'),(4,'Pizzería');

CREATE TABLE estilos_sucursales (
    nro_restaurante INT NOT NULL,
    nro_sucursal INT NOT NULL,
    nro_estilo INT NOT NULL,
    habilitado INT NOT NULL DEFAULT 1,
    PRIMARY KEY (nro_restaurante, nro_sucursal, nro_estilo),
    FOREIGN KEY (nro_restaurante, nro_sucursal)
        REFERENCES sucursales (nro_restaurante, nro_sucursal),
    FOREIGN KEY (nro_estilo) REFERENCES estilos (nro_estilo)
);

INSERT INTO estilos_sucursales VALUES
(1,1,1,1),(1,1,4,1),(1,2,2,1),(1,2,3,0);

CREATE TABLE tipos_comidas (
    nro_tipo_comida INT PRIMARY KEY,
    nom_tipo_comida VARCHAR(100) NOT NULL
);

INSERT INTO tipos_comidas VALUES
(1,'Carnes'),(2,'Pastas'),(3,'Pescados y Mariscos'),(4,'Comida Vegetariana'),
(5,'Comida Vegana'),(6,'Pizzas'),(7,'Postres'),(8,'Bebidas');

CREATE TABLE tipos_comidas_sucursales (
    nro_restaurante INT NOT NULL,
    nro_sucursal INT NOT NULL,
    nro_tipo_comida INT NOT NULL,
    habilitado INT NOT NULL DEFAULT 1,
    PRIMARY KEY (nro_restaurante, nro_sucursal, nro_tipo_comida),
    FOREIGN KEY (nro_restaurante, nro_sucursal)
        REFERENCES sucursales (nro_restaurante, nro_sucursal),
    FOREIGN KEY (nro_tipo_comida) REFERENCES tipos_comidas (nro_tipo_comida)
);

INSERT INTO tipos_comidas_sucursales VALUES
(1,1,1,1),(1,1,6,1),(1,1,7,1),(1,2,2,1),(1,2,4,1),(1,2,8,1);

CREATE TABLE especialidades_alimentarias (
    nro_restriccion INT PRIMARY KEY,
    nom_restriccion VARCHAR(100) NOT NULL
);

INSERT INTO especialidades_alimentarias VALUES
(1,'Sin gluten'),(2,'Sin lactosa'),(3,'Vegetariana'),
(4,'Vegana'),(5,'Apta para diabéticos'),(6,'Baja en sodio'),(7,'Sin frutos secos');

CREATE TABLE especialidades_alimentarias_sucursales (
    nro_restaurante INT NOT NULL,
    nro_sucursal INT NOT NULL,
    nro_restriccion INT NOT NULL,
    habilitada INT NOT NULL DEFAULT 1,
    PRIMARY KEY (nro_restaurante, nro_sucursal, nro_restriccion),
    FOREIGN KEY (nro_restaurante, nro_sucursal)
        REFERENCES sucursales (nro_restaurante, nro_sucursal),
    FOREIGN KEY (nro_restriccion)
        REFERENCES especialidades_alimentarias (nro_restriccion)
);

INSERT INTO especialidades_alimentarias_sucursales VALUES
(1,1,1,1),(1,1,2,1),(1,1,5,1),(1,2,3,1),(1,2,4,1),(1,2,6,0);

CREATE TABLE contenidos (
    nro_restaurante INT NOT NULL,
    nro_contenido INT NOT NULL,
    contenido_a_publicar TEXT NOT NULL,
    imagen_a_publicar VARCHAR(255),
    publicado INT NOT NULL DEFAULT 0,
    costo_click DECIMAL(10,2) NOT NULL DEFAULT 0,
    nro_sucursal INT,
    PRIMARY KEY (nro_restaurante, nro_contenido),
    FOREIGN KEY (nro_restaurante) REFERENCES restaurantes (nro_restaurante),
    FOREIGN KEY (nro_restaurante, nro_sucursal)
        REFERENCES sucursales (nro_restaurante, nro_sucursal)
);

INSERT INTO contenidos VALUES
(1,1,'Promo mediodía: menú parrilla + bebida','https://imgs.example.com/promo_mediodia.jpg',1,15.00,1),
(1,2,'Noche de pizzas a la piedra 2x1','https://imgs.example.com/pizzas_2x1.jpg',1,12.50,1),
(1,3,'Pastas caseras en sucursal Nueva Cba','https://imgs.example.com/pastas.jpg',0,10.00,2);

CREATE TABLE clicks_contenidos (
    nro_restaurante INT NOT NULL,
    nro_contenido INT NOT NULL,
    nro_click INT NOT NULL,
    fecha_hora_registro DATETIME NOT NULL,
    nro_cliente INT NOT NULL,
    costo_click DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (nro_restaurante, nro_contenido, nro_click),
    FOREIGN KEY (nro_restaurante, nro_contenido)
        REFERENCES contenidos (nro_restaurante, nro_contenido),
    FOREIGN KEY (nro_cliente) REFERENCES clientes (nro_cliente)
);



-- SELECT
--     s.nro_restaurante,
--     s.nro_sucursal,
--     s.nom_sucursal,
--     s.calle,
--     s.nro_calle,
--     s.barrio,
--     l.nom_localidad AS localidad,
--     p.nom_provincia AS provincia,
--     s.cod_postal,
--     s.telefonos,
--     s.total_comensales,
--     s.min_tolerancia_reserva,
--     c.nom_categoria AS categoria
-- FROM sucursales s
-- JOIN localidades l ON s.nro_localidad = l.nro_localidad
-- JOIN provincias p ON l.cod_provincia = p.cod_provincia
-- JOIN categorias_precios c ON s.nro_categoria = c.nro_categoria;

IF OBJECT_ID('sp_get_provincias', 'P') IS NOT NULL
    DROP PROCEDURE sp_get_provincias;
GO

CREATE PROCEDURE sp_get_provincias
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        cod_provincia, 
        nom_provincia
    FROM provincias
    ORDER BY nom_provincia;
END;



IF OBJECT_ID('dbo.sp_insert_click_contenido', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_insert_click_contenido;
GO

CREATE OR ALTER PROCEDURE dbo.sp_insert_click_contenido
    @nro_restaurante     INT,
    @nro_contenido       INT,
    @nro_click           INT,
    @fecha_hora_registro DATETIME,
    @nro_cliente         INT,
    @costo_click         DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;

        INSERT INTO dbo.clicks_contenidos (
            nro_restaurante,
            nro_contenido,
            nro_click,
            fecha_hora_registro,
            nro_cliente,
            costo_click
        )
        VALUES (
            @nro_restaurante,
            @nro_contenido,
            @nro_click,
            @fecha_hora_registro,
            @nro_cliente,
            @costo_click
        );

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK TRAN;

        -- Reexpone el error original con su severidad/estado.
        THROW;
    END CATCH
END;
GO


SELECT * from clicks_contenidos;
