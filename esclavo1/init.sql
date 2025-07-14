CREATE DATABASE IF NOT EXISTS db_informacion;

USE db_informacion;

CREATE TABLE IF NOT EXISTS datos (
    nombre VARCHAR(20),
    correo VARCHAR(50),
    experiencia VARCHAR(250),
    formacion VARCHAR(250)
);

INSERT INTO datos (nombre, correo, experiencia, formacion) VALUES 
("Joseph Caza", "joseph.caza@epn.edu.ec", "Software Dev", "Escuela Politecnica Nacional - Tecnologia en Desarrollo de Software"),
("Mateo Garzon", "mateo.garzon@epn.edu.ec", "Software Dev", "Escuela Politecnica Nacional - Tecnologia en Desarrollo de Software");
