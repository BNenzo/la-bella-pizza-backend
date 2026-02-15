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
    nom_localidad VARCHAR(50) NOT NULL,
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
(1, 'Económico/Bajo'), (2, 'Medio'), (3, 'Alto/Premium'), (4, 'De lujo');

CREATE TABLE restaurantes (
    nro_restaurante INT PRIMARY KEY,
    razon_social VARCHAR(50) NOT NULL,
    cuit CHAR(11) UNIQUE NOT NULL
);

INSERT INTO restaurantes VALUES (1, 'La Bella Pizza', '30717101975');

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
(1,1,'La Bella Pizza Alta Córdoba','Juan Antonio Lavalleja',2344,'Alta Córdoba',1,'5001','03512317731',50,15,2),
(1,2,'La Bella Pizza General Paz','Jacinto Ríos',170,'General Paz',1,'5004','03515388931',30,12,2);

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
('VBEL','Villa Belgrano'),
('JUNI','Jardín'),
('URCA','Urca'),
('SANV','San Vicente'),
('OBLA','Observatorio'),
('ARGU','Argüello'),
('MAIP','Maipú'),
('POET','Poeta Lugones'),
('RSME','Residencial San Martín'),
('IPON','Iponá'),
('GUIZ','Guiñazú'),
('PATR','Patricios'),
('VILL','Villa Cabrera'),
('VILLP','Villa Páez'),
('SAGU','San Gerónimo'),
('LOSGL','Los Gigantes'),
('BAJO','Bajo Alberdi');


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

INSERT INTO zonas_sucursales VALUES (1,1,'ACBA',50,1,1),(1,2,'GPZ',30,1,1);

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
(1,1,'12:00','13:30',1),
(1,1,'13:30','14:30',1),
(1,1,'14:30','15:30',1),
(1,1,'20:00','21:30',1),
(1,1,'21:30','22:30',1),
(1,1,'22:30','23:30',1),
(1,2,'12:00','13:15',1),
(1,2,'20:00','21:00',0);

CREATE TABLE zonas_turnos_sucursales (
    nro_restaurante INT NOT NULL,
    nro_sucursal INT NOT NULL,
    hora_desde TIME NOT NULL,
    cod_zona CHAR(5) NOT NULL,
    permite_menores INT NOT NULL DEFAULT 1,
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
(1,'Letona','Renzo','renzo.letona@example.com','351-1112233'),
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

-- INSERT INTO reservas_sucursales VALUES
-- ('LBP-001-R001','2025-11-02 18:30:00',1,'2025-11-05',1,1,'ACBA','12:00',2,0,12000.00,0,NULL),
-- ('LBP-001-R002','2025-11-02 18:45:00',2,'2025-11-05',1,1,'ACBA','20:00',4,2,18000.00,0,NULL);

CREATE TABLE estilos (
    nro_estilo INT PRIMARY KEY,
    nom_estilo VARCHAR(100) NOT NULL
);


INSERT INTO estilos VALUES
(1, 'Gourmet'),
(2, 'Casual'),
(3, 'Comida rápida / Fast food'),
(4, 'Buffet libre'),
(5, 'Bistró'),
(6, 'Food truck'),
(7, 'Restaurante tradicional'),
(8, 'Bar / Tapas'),
(9, 'Cafetería'),
(10, 'Delivery'),
(11, 'Fine dining');

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
(1,1,2,1),(1,1,3,1),(1,2,2,1),(1,2,3,1);

CREATE TABLE tipos_comidas (
    nro_tipo_comida INT PRIMARY KEY,
    nom_tipo_comida VARCHAR(100) NOT NULL
);

INSERT INTO tipos_comidas VALUES
(1, 'Italiana'),
(2, 'Mexicana'),
(3, 'Española'),
(4, 'Francesa'),
(5, 'Japonesa'),
(6, 'China'),
(7, 'Tailandesa'),
(8, 'India'),
(9, 'Mediterránea'),
(10, 'Argentina'),
(11, 'Peruana'),
(12, 'Árabe / Medio Oriente'),
(13, 'Americana'),
(14, 'Fusión'),
(15, 'Internacional');

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
(1,1,1,1),(1,2,1,1);

CREATE TABLE especialidades_alimentarias (
    nro_restriccion INT PRIMARY KEY,
    nom_restriccion VARCHAR(100) NOT NULL
);

INSERT INTO especialidades_alimentarias VALUES
(1, 'Vegetariana'),
(2, 'Vegana'),
(3, 'Sin gluten / Celíaco'),
(4, 'Sin lactosa'),
(5, 'Baja en calorías'),
(6, 'Orgánica'),
(7, 'Diabéticos (sin azúcar añadida)');

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
(1,1,1,1),(1,1,3,1),(1,2,1,1),(1,2,3,1);

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
(1,1,'Promo mediodía: Pizza a la piedra + bebida','https://tn.com.ar/resizer/z2Dke2M5Hbz4s3VRE_OClr_-fXU=/arc-anglerfish-arc2-prod-artear/public/FOTWE3GMANB6BPQKQB4GER55MM.jpeg',0,15.00,1),
(1,2,'Noche de pizzas a la piedra 2x1','https://www.paulinacocina.net/wp-content/uploads/2024/05/receta-de-pizza-frita-paulina-cocina-recetas-800x450.jpg',0,12.50,1),
(1,3,'Degustacion de pizzas en sucursal Alta Cba','https://external-preview.redd.it/dominos-50-off-pizza-deal-returns-april-21-27-2025-v0-fmRa26hiSj0oi3Ob8jddYxIJCAft4z0H26lGC1J9KvE.jpg?width=640&crop=smart&auto=webp&s=34ace06ed3c90f079c718796a0ce7496ea4f5f32',0,10.00,2);

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
GO


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

        THROW;
    END CATCH
END;
GO

-- OBTENER CONTENIDOS NO PUBLICADOS
CREATE OR ALTER PROCEDURE sp_get_contenidos_no_publicados
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        nro_restaurante,
        nro_contenido,
        contenido_a_publicar,
        imagen_a_publicar,
        publicado,
        costo_click,
        nro_sucursal
    FROM contenidos
    WHERE publicado = 0;
END
GO


-- INSERT CLIENTE DESDE RISTORINO SOLO SI NO EXISTE
CREATE OR ALTER PROCEDURE sp_insert_cliente_desde_ristorino
  @nro_cliente INT,
  @apellido VARCHAR(100),
  @nombre VARCHAR(100),
  @correo VARCHAR(150),
  @telefonos VARCHAR(50)
AS
BEGIN
  SET NOCOUNT ON;

  IF NOT EXISTS (
    SELECT 1
    FROM clientes
    WHERE nro_cliente = @nro_cliente
  )
  BEGIN
    INSERT INTO clientes (
      nro_cliente,
      apellido,
      nombre,
      correo,
      telefonos
    )
    VALUES (
      @nro_cliente,
      @apellido,
      @nombre,
      @correo,
      @telefonos
    );
  END
END;
GO


-- INSERT DE UN TURNO
CREATE OR ALTER PROCEDURE sp_crear_reserva_sucursal
  @cod_reserva VARCHAR(50),
  @nro_cliente INT,
  @fecha_reserva DATE,
  @nro_restaurante INT,
  @nro_sucursal INT,
  @cod_zona CHAR(5),
  @hora_reserva TIME,
  @cant_adultos INT,
  @cant_menores INT,
  @costo_reserva DECIMAL(10,2)
AS
BEGIN
  SET NOCOUNT ON;

  INSERT INTO reservas_sucursales (
    cod_reserva,
    fecha_hora_registro,
    nro_cliente,
    fecha_reserva,
    nro_restaurante,
    nro_sucursal,
    cod_zona,
    hora_reserva,
    cant_adultos,
    cant_menores,
    costo_reserva,
    cancelada,
    fecha_cancelacion
  )
  VALUES (
    @cod_reserva,
    CURRENT_TIMESTAMP,
    @nro_cliente,
    @fecha_reserva,
    @nro_restaurante,
    @nro_sucursal,
    @cod_zona,
    @hora_reserva,
    @cant_adultos,
    @cant_menores,
    @costo_reserva,
    0,
    NULL
  );
END;
GO


-- ACTUALIZAR LA RESERVA DE UN CLIENTE
CREATE OR ALTER PROCEDURE dbo.sp_actualizar_reserva_cliente
    @cod_reserva   VARCHAR(50),
    @fecha_reserva DATE,
    @hora_reserva  TIME,
    @cant_adultos  INT,
    @fecha_cancelacion DATE,
    @cancelada INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;

        -- Actualización
        UPDATE rs
        SET
            rs.fecha_reserva = COALESCE(@fecha_reserva, rs.fecha_reserva),
            rs.hora_reserva  = COALESCE(@hora_reserva, rs.hora_reserva),
            rs.cant_adultos  = COALESCE(@cant_adultos, rs.cant_adultos),
            rs.fecha_cancelacion  = COALESCE(@fecha_cancelacion, rs.fecha_cancelacion),
            rs.cancelada  = COALESCE(@cancelada, rs.cancelada)
        FROM dbo.reservas_sucursales AS rs
        WHERE cod_reserva = @cod_reserva;

        -- Si no existe la reserva
        IF @@ROWCOUNT = 0
            THROW 50002, 'No existe una reserva con ese cod_reserva.', 1;

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK TRAN;
        THROW;
    END CATCH
END;
GO



SELECT * from reservas_sucursales
select * from clientes