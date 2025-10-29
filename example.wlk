class Nave {
  method prepararViaje()
  method escapar()
  method avisar()
  method tienePocaActividad()
  var combustible
  var velocidad
  var direccion
  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }
  method estaTranquila()= combustible>=4000 and velocidad <= 12000
  method estaDeRelajo() = self.estaTranquila() and tienePocaActividad()
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
  var cambioBaliza = false
  method cambioUnaVezBaliza() = cambioBaliza
  method cambiarColorBaliza(unColorNuevo) {
    color = unColorNuevo
    cambioBaliza = true
  }  
  method color() = color  
  
  override method prepararViaje() {
    self.accionAdicional()
    self.cambiarColorBaliza("verde")
    cambioBaliza = true
    self.ponerseParaleloAlSol()
  }
  override method estaTranquila() = super() and  color != "rojo"
  override method escapar(){
    self.irHaciaElSol()
  }
  override method avisar(){
    self.cambiarColorBaliza("rojo")
  }
  override method tienePocaActividad()= self.cambioUnaVezBaliza()==false

}

class NavePasajeros inherits Nave{
  var cantidadPasajeros
  var racionesComida
  var racionesBebida
  var racionesDadas
  method cargarCantidadBebida(cantidadDeBebida) {
    racionesBebida += cantidadDeBebida
  }
  method cargarCantidadComida(cantidadComida) {
    racionesComida += cantidadComida
  }
  method darRacionesDeComidasAPasajeros(cantidadRacion){
    racionesComida -= cantidadRacion * cantidadPasajeros
    racionesDadas+=cantidadRacion
  }
  method darRacionesDeBebidasAPasajeros(cantidadRacion){
    racionesBebida -= cantidadRacion * cantidadPasajeros
  }

  
  override method prepararViaje() {
    self.accionAdicional()
    self.cargarCantidadComida(4 * cantidadPasajeros)
    self.cargarCantidadBebida(6 * cantidadPasajeros)
    self.acercarseUnPocoAlSol()
  } 

  override method estaTranquila() = super()
  override method escapar(){
    self.velocidad * 2
  }
  override method avisar(){
    self.darRacionesDeComidasAPasajeros(1)
    self.darRacionesDeBebidasAPasajeros(2)
  }
  override method tienePocaActividad()= racionesDadas < 50
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
  override method estaTranquila() = super() and not self.misilesDesplegados()
  override method escapar(){
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }
  override method avisar(){
    self.emitirMensaje("Amenaza recibida")
  }
  override method tienePocaActividad() = self.misilesDesplegados == false
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

  override method estaTranquila() = super() and self.quirofanosPreparados()

  override method recibirAmenaza(){
    super()
    self.prepararQuirofanos()
  }
  override method tienePocaActividad()= not self.quirofanosPreparados()


}

class NaveCombateSigilosa inherits NaveCombate{

  override method estaTranquila() = super() and not self.estaInvisible()
  override method escapar(){
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
  
}