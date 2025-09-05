from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Usuario(db.Model):
    __tablename__ = 'usuario'

    Correo = db.Column(db.String(120), primary_key=True)
    Nombres = db.Column(db.String(70))
    Apellidos = db.Column(db.String(70))
    Contraseña = db.Column(db.String(60), nullable=False)
    Profesion = db.Column(db.String(40))
    FechaDeNacimiento = db.Column(db.Date)
    Expectativas = db.Column(db.Text)
    NombreUsuario = db.Column(db.String(50), unique=True, nullable=False)
    Foto = db.Column(db.LargeBinary)
    rol = db.Column(db.Enum('admi','userN', name='rol_enum'), nullable=False, default='userN')

    presupuestos = db.relationship('Presupuesto', back_populates='usuario')
    recordatorios = db.relationship('Recordatorio', back_populates='usuario')
    telefonos = db.relationship('Telefono', back_populates='usuario')

class Tipopresupuesto(db.Model):
    __tablename__ = 'tipopresupuesto'

    idTipoPresupuesto = db.Column(db.Integer, primary_key=True)
    TipoDePresupuesto = db.Column(db.String(50))

    presupuestos = db.relationship('Presupuesto', back_populates='tipo_presupuesto')

class Presupuesto(db.Model):
    __tablename__ = 'presupuesto'

    idPresupuesto = db.Column(db.Integer, primary_key=True)
    Fecha = db.Column(db.Date)
    idTipoPresupuesto = db.Column(db.Integer, db.ForeignKey('tipopresupuesto.idTipoPresupuesto'), nullable=False)
    Dinero = db.Column(db.Numeric(10,0))
    Ahorros = db.Column(db.Numeric(10,0))
    NombreUsuario = db.Column(db.String(50), db.ForeignKey('usuario.NombreUsuario'), nullable=False)

    tipo_presupuesto = db.relationship('Tipopresupuesto', back_populates='presupuestos')
    usuario = db.relationship('Usuario', back_populates='presupuestos')

    creditos = db.relationship('Credito', back_populates='presupuesto')
    cuentas = db.relationship('Cuenta', back_populates='presupuesto')
    detalle_presupuesto = db.relationship('DetallePresupuesto', back_populates='presupuesto')
    gastos = db.relationship('Gasto', back_populates='presupuesto')
    ingresos = db.relationship('Ingreso', back_populates='presupuesto')

class Tipodecredito(db.Model):
    __tablename__ = 'tipodecredito'

    idTipoDeCredito = db.Column(db.Integer, primary_key=True)
    TipoDeCredito = db.Column(db.String(50))

    creditos = db.relationship('Credito', back_populates='tipo_credito')

class Credito(db.Model):
    __tablename__ = 'creditos'

    idCreditos = db.Column(db.Integer, primary_key=True)
    idPresupuesto = db.Column(db.Integer, db.ForeignKey('presupuesto.idPresupuesto'), nullable=False)
    RangoInicial = db.Column(db.Date)
    RangoFinal = db.Column(db.Date)
    MontoTotal = db.Column(db.Numeric(10,0))
    idTipoDeCredito = db.Column(db.Integer, db.ForeignKey('tipodecredito.idTipoDeCredito'), nullable=False)

    presupuesto = db.relationship('Presupuesto', back_populates='creditos')
    tipo_credito = db.relationship('Tipodecredito', back_populates='creditos')
    pagos = db.relationship('PagoDeCredito', back_populates='credito')

class PagoDeCredito(db.Model):
    __tablename__ = 'pagodecredito'

    idPagoDeCredito = db.Column(db.Integer, primary_key=True)
    TipoDePago = db.Column(db.String(50))
    idCreditos = db.Column(db.Integer, db.ForeignKey('creditos.idCreditos'), nullable=False)
    AccionRealizada = db.Column(db.String(50))

    credito = db.relationship('Credito', back_populates='pagos')

class Cuenta(db.Model):
    __tablename__ = 'cuentas'

    idCuentas = db.Column(db.Integer, primary_key=True)
    Banco = db.Column(db.Text)
    Monto = db.Column(db.Numeric(10,0))
    idPresupuesto = db.Column(db.Integer, db.ForeignKey('presupuesto.idPresupuesto'), nullable=False)

    presupuesto = db.relationship('Presupuesto', back_populates='cuentas')

class DetallePresupuesto(db.Model):
    __tablename__ = 'detallepresupuesto'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    idPresupuesto = db.Column(db.Integer, db.ForeignKey('presupuesto.idPresupuesto'))
    categoria = db.Column(db.Enum('Casa','Comida','Trabajo','Otros', name='categoria_enum'), nullable=False)
    tipo_movimiento = db.Column(db.Enum('Ingreso','Gasto', name='tipo_movimiento_enum'), nullable=False)
    destino = db.Column(db.Enum('presupuestado','real', name='destino_enum'), nullable=False)
    monto = db.Column(db.Numeric(10,2), nullable=False)

    presupuesto = db.relationship('Presupuesto', back_populates='detalle_presupuesto')

class Gasto(db.Model):
    __tablename__ = 'gastos'

    idGastos = db.Column(db.Integer, primary_key=True)
    idPresupuesto = db.Column(db.Integer, db.ForeignKey('presupuesto.idPresupuesto'), nullable=False)
    FechaDeRegistro = db.Column(db.Date)
    Monto = db.Column(db.Numeric(10,0))
    TipoDeMonto = db.Column(db.Enum('Efectivo','Tarjeta Debito','Tarjeta credito','Cheque','Billeteras virtuales', name='tipomonto_enum'))

    presupuesto = db.relationship('Presupuesto', back_populates='gastos')

class Ingreso(db.Model):
    __tablename__ = 'ingresos'

    idIngresos = db.Column(db.Integer, primary_key=True)
    idPresupuesto = db.Column(db.Integer, db.ForeignKey('presupuesto.idPresupuesto'), nullable=False)
    FechaDeRegistro = db.Column(db.Date)
    Monto = db.Column(db.Numeric(10,0))
    TipoDeMonto = db.Column(db.Enum('Efectivo','Tarjeta Debito','Tarjeta credito','Cheque','Billeteras virtuales', name='tipomonto_enum'))

    presupuesto = db.relationship('Presupuesto', back_populates='ingresos')

class Recordatorio(db.Model):
    __tablename__ = 'recordatorios'

    idRecordatorios = db.Column(db.Integer, primary_key=True)
    Comentario = db.Column(db.String(120))
    NombreUsuario = db.Column(db.String(50), db.ForeignKey('usuario.NombreUsuario'), nullable=False)

    usuario = db.relationship('Usuario', back_populates='recordatorios')
    tipos = db.relationship('TipoDeRecordatorio', back_populates='recordatorio')

class TipoDeRecordatorio(db.Model):
    __tablename__ = 'tiposderecordatorios'

    idTiposDeRecordatorios = db.Column(db.Integer, primary_key=True)
    TipoDeRecordatorio = db.Column(db.String(50))
    idRecordatorios = db.Column(db.Integer, db.ForeignKey('recordatorios.idRecordatorios'), nullable=False)

    recordatorio = db.relationship('Recordatorio', back_populates='tipos')

class Telefono(db.Model):
    __tablename__ = 'telefonos'

    idTelefono = db.Column(db.Integer, primary_key=True)
    Numero = db.Column(db.String(15))
    NombreUsuario = db.Column(db.String(50), db.ForeignKey('usuario.NombreUsuario'), nullable=False)

    usuario = db.relationship('Usuario', back_populates='telefonos')
