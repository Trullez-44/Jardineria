CREATE TABLE hospital_complexes(
    complex_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY hospital_complexes_complex_id_primary(complex_id));
CREATE TABLE buildings(
    building_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    complex_id INT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    constraint pk_id PRIMARY KEY buildings_building_id_primary(building_id));
CREATE TABLE employees(
    employee_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    type ENUM('Boss','Employee') NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY employees_employee_id_primary(employee_id)
);
CREATE TABLE floors(
    building_floor_id VARCHAR(20) NOT NULL,
    floor_id INTEGER UNSIGNED  NOT NULL,
    building_id INTEGER NOT NULL,
    employee_id INT UNSIGNED NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY floors_floor_id_primary(floor_id));
CREATE TABLE specialties(
speciality_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
CONSTRAINT pk_id PRIMARY KEY specialties_speciality_id_primary(speciality_id)
);
CREATE TABLE specialties_per_floor(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    type ENUM('Main','Secondary') NOT NULL,
    floor_id INT UNSIGNED NOT NULL,
    speciality_id INT UNSIGNED NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY specialties_per_floor_type_primary(id)
);


CREATE TABLE rooms(
    room_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    floor_id INT UNSIGNED NOT NULL,
    bed_count TINYINT UNSIGNED NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY rooms_room_id_primary(room_id)
);

ALTER TABLE
    buildings ADD CONSTRAINT buildings_complex_id_foreign FOREIGN KEY(complex_id) REFERENCES hospital_complexes(complex_id);
ALTER TABLE
    specialties_per_floor ADD CONSTRAINT specialties_per_floor_speciality_id_foreign FOREIGN KEY(speciality_id) REFERENCES specialties(speciality_id);
ALTER TABLE
    floors ADD CONSTRAINT floors_employee_id_foreign FOREIGN KEY(employee_id) REFERENCES employees(employee_id);
ALTER TABLE
    floors ADD CONSTRAINT floors_building_id_foreign FOREIGN KEY(building_id) REFERENCES buildings(building_id);
ALTER TABLE
    rooms ADD CONSTRAINT rooms_floor_id_foreign FOREIGN KEY(floor_id) REFERENCES floors(floor_id);
ALTER TABLE
    specialties_per_floor ADD CONSTRAINT specialties_per_floor_floor_id_foreign FOREIGN KEY(floor_id) REFERENCES floors(floor_id);
ALTER TABLE
    floors ADD CONSTRAINT unique_to_pk UNIQUE(building_floor_id);


/*  */
INSERT INTO hospital_complexes (name) VALUES
('Complejo Hospitalario Bogotá'),
('Centro Médico Medellín'),
('Hospital de Cali'),
('Santa Marta Health Center'),
('Clínica Cartagena');
INSERT INTO hospital_complexes (name) VALUES
('Clínica Salud Integral'),
('Hospital San Francisco'),
('Centro Médico Caldas'),
('Clínica Versalles'),CREATE TABLE employees(
    employee_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    type ENUM('Boss','Employee') NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    CONSTRAINT pk_id PRIMARY KEY employees_employee_id_primary(employee_id)
);
('Hospital Santa Rosa');
/*  */
INSERT INTO buildings (complex_id, name, address) VALUES
(1, 'Hospital San Juan', 'Carrera 12 #34-56, Bogotá'),
(1, 'Clínica Los Pinos', 'Avenida 7 #45-78, Medellín'),
(2, 'Centro Médico Cali', 'Calle 23 #67-89, Cali'),
(3, 'Hospital Santa Marta', 'Carrera 5 #12-34, Santa Marta'),
(2, 'Clínica Aurora', 'Avenida 10 #56-78, Cali'),
(4, 'Hospital Cartagena', 'Calle 30 #45-67, Cartagena'),
(3, 'Centro de Salud Barranquilla', 'Carrera 15 #34-56, Barranquilla'),
(4, 'Clínica Salud y Vida', 'Calle 40 #23-45, Cartagena'),
(1, 'Hospital Los Alamos', 'Avenida 8 #90-12, Bogotá'),
(2, 'Centro Médico Valle', 'Carrera 50 #67-45, Cali');
/*  */
INSERT INTO employees (type, first_name, last_name, gender) VALUES
('Boss', 'Carlos', 'González', 'Male'),
('Employee', 'Laura', 'Martínez', 'Female'),
('Employee', 'Andrés', 'Hernández', 'Male'),
('Employee', 'Ana', 'Ramírez', 'Female'),
('Boss', 'Javier', 'López', 'Male'),
('Employee', 'Camila', 'Pérez', 'Female'),
('Employee', 'David', 'Díaz', 'Male'),
('Employee', 'Isabella', 'Gómez', 'Female'),
('Boss', 'Sofía', 'Mendoza', 'Female'),
('Employee', 'Juan', 'Rodríguez', 'Male');
/*  */
INSERT INTO floors (building_floor_id, floor_id, building_id, employee_id) VALUES
('B10F1', 1, 20, 1),
('B11F2', 2, 11, 3),
('B12F3', 3, 12, 5),
('B13F2', 4, 13, 2),
('B14F1', 5, 14, 4),
('B15F3', 6, 15, 7),
('B16F1', 7, 16, 6),
('B17F2', 8, 17, 9),
('B18F3', 9, 18, 8),
('B19F4', 10, 19, 10);
/*  */
INSERT INTO specialties (name) VALUES
('Cardiología'),
('Neurología'),
('Gastroenterología'),
('Pediatría'),
('Oncología'),
('Dermatología'),
('Oftalmología'),
('Cirugía General'),
('Ortopedia'),
('Endocrinología');
/*  */
INSERT INTO specialties_per_floor (type, floor_id, speciality_id) VALUES
('Main', 1, 1),
('Secondary', 2, 2),
('Main', 3, 3),
('Secondary', 1, 4),
('Main', 2, 5),
('Secondary', 3, 6),
('Main', 1, 7),
('Secondary', 2, 8),
('Main', 3, 9),
('Secondary', 1, 10);
/*  */
INSERT INTO rooms (floor_id, bed_count) VALUES
(1, 5),
(2, 3),
(3, 4),
(1, 2),
(2, 3),
(3, 2),
(1, 4),
(2, 3),
(3, 5),
(1, 2);
/* #Obtener el nombre del empleado que trabaja en el piso con id 3.
SELECT * FROM floors;
#Mostrar el nombre y la especialidad de los pisos principales.

#Obtener el nombre del complejo hospitalario al que pertenece el edificio con id 5.

#Mostrar el nombre y la cantidad de camas de las habitaciones en el piso con id 8.

#Obtener el nombre del empleado que trabaja en el edificio con id 6.

#Mostrar el nombre de las especialidades en el piso principal del edificio con id 3.

#Obtener el nombre y el cargo de los empleados que trabajan en el edificio con id 7.

#Mostrar el nombre y la ubicación de los pisos con más de 15 camas.

#Obtener el nombre del complejo hospitalario que tiene el mayor número de edificios.

#Mostrar el nombre y la especialidad de los empleados que trabajan en el piso principal del edificio con id 1.

#Obtener el nombre y la ubicación de los pisos donde trabaja un "Jefe".

#Mostrar el nombre y el cargo de los empleados que trabajan en más de un piso.

#Obtener el nombre y la cantidad de camas de las habitaciones en el piso principal del edificio con id 2.

#Mostrar el nombre del complejo hospitalario que tiene al menos un edificio sin asignación de empleados. */