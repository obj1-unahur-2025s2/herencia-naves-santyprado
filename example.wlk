class Nave {
  method prepararViaje()
  var combustible
  var velocidad
  var direccion
  method estaTranquila()= combustible>=4000 and velocidad <= 12000
  method accionAdicional() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }
  method acelerar(unaVelocidad) {
    velocidad =(velocidad+unaVelocidad).min(100000)
  }
  method desacelerar(unaVelocidad) {
    velocidad = (velocidad-unaVelocidad).max(0)
  }
  method irHaciaElSol(){
    direccion = 10
  }
  method escaparDelSol(){
    direccion = -10
  }
  method ponerseParaleloAlSol() {
    direccion = 0
  }
  method acercarseUnPocoAlSol() {
    direccion = (direccion + 1).min(10)
  }
  method alejarseUnPocoDelSol() {
    direccion = (direccion-1).max(-10)
  }
  method cargarCombustible(cantidadCombustible){
    combustible+= cantidadCombustible 
  }
  method descargarCombustible(cantidadCombustible) {
    combustible-= cantidadCombustible
  }
  
}

class NaveBaliza inherits Nave {
  var color
  method cambiarColorBaliza(unColorNuevo) {
    color = unColorNuevo
  }  
  method color() = color  
  override method prepararViaje() {
    self.accionAdicional()
    self.cambiarColorBaliza("verde")
    self.ponerseParaleloAlSol()
  }
  override method estaTranquila() = super() and  color != "rojo"


}

class NavePasajeros inherits Nave{
  var cantidadPasajeros
  var racionesComida
  var racionesBebida
  method cargarCantidadBebida(cantidadDeBebida) {
    racionesBebida += cantidadDeBebida
  }
  method cargarCantidadComida(cantidadComida) {
    racionesComida += cantidadComida
  }
  override method prepararViaje() {
    self.accionAdicional()
    self.cargarCantidadComida(4 * cantidadPasajeros)
    self.cargarCantidadBebida(6 * cantidadPasajeros)
    self.acercarseUnPocoAlSol()
  } 
  override method estaTranquila() = super()
}

class NaveCombate inherits Nave{
  var invisible
  var misiles
  const mensajes = []
  method ponerseInvisible() {
    invisible = true
  }
  method ponerseVisible() {
    invisible = false
  }
  method estaInvisible() = invisible
  method desplegarMisiles(){
    misiles = true
  }
  method replegarMisiles() {
    misiles = false
  }
  method misilesDesplegados() =  misiles

  method emitirMensaje(unMensaje) {
    mensajes.add(unMensaje)
  }
  method mensajesEmitidos() = mensajes 
  method esEscueta() = mensajes.all({m=>m.length()>30}) 
  method primerMensajeEmitido() =  mensajes.first()
  method ultimoMensajeEmitido() = mensajes.last()
  method emitioMensaje(unMensaje) = mensajes.contains(unMensaje)
  override method prepararViaje() {
    self.accionAdicional()
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en Misión")
  } 
  override method estaTranquila() = super()
}

class NaveHospital inherits NavePasajeros {
  
  var quirofanosPreparados = false

  method prepararQuirofanos(){
    quirofanosPreparados = true
  }
  method utilizarQuirofano(){
    quirofanosPreparados = false
  }
  method quirofanosPreparados() = quirofanosPreparados


}

class NaveCombateSigilosa inherits NaveCombate{

  override method estaTranquila() =
}