CREATE USER ‘Administrativo’ IDENTIFIED BY '123456';
CREATE USER ‘Operacional’ IDENTIFIED BY '123456';

CREATE ROLE ‘interface_web’ ;
CREATE ROLE ‘interface_equip’ ;


GRANT SELECT, INSERT ON bd_pigma.* TO ‘Administrativo’;
GRANT SELECT, INSERT, DELETE, ALTER ON *.* TO ‘Operacional’ ;

GRANT ‘interface_web’ TO ‘Administrativo’;
GRANT ‘interface_equip’ TO ‘Operacional’;
