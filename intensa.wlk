object intensamente {
  var property intensidadLimite = 10
  const personas = []
  method agregar(p){
    personas.add(p)
  }

  method cantidadPorExplotar() = personas.count{p=>p.porExplotar()}

  method todosViven(evento) {
    personas.forEach{p=>p.vivir(evento)}
  }
}

class Persona {
  var property edad
  const emociones = []

  method esAdolescente() = edad.between(12,19)

  method tenerEmocion(nueva){
    emociones.add(nueva)
  }

  method porExplotar() = 
    emociones.all{e=>e.puedeLiberarse()}

  method vivir(evento){
    emociones.forEach{e=>e.intentarLiberarse(evento)}
  }
}


class Emocion{
  var cantidadEventos = 0
  var property intensidad 
  method puedeLiberarse() =  
    intensidad > intensamente.intensidadLimite() and 
    self.condicionAdicional()
  
  method condicionAdicional()

  method intentarLiberarse(evento) {
    if(self.puedeLiberarse())
      self.liberarse(evento)
    cantidadEventos +=1
  }
  method liberarse(evento){
    self.intensidad( intensidad - evento.impacto())
  }
}
class Ansiedad inherits Furia{
   override method liberarse(evento) {  }
}

class Furia inherits Emocion(intensidad=100){
  const palabrotas = []
  override method condicionAdicional() =  
     palabrotas.any{p=>p.size() >= 7}
  override method liberarse(evento){
    super(evento)
    palabrotas.remove(palabrotas.first())
  } 
  method aprender(pal){
    palabrotas.add(pal)
  }
}

class Alegria inherits Emocion{
  override method condicionAdicional() =  
    cantidadEventos.even()
  
  override method intensidad(valor){
      intensidad = valor.abs()
  }
}

class Tristeza inherits Emocion {
  var property causa = "melancolia"
  override method condicionAdicional() =  
    causa != "melancolia"
  override method liberarse(evento){
    super(evento)
    causa= evento.descripcion()
  } 
}

class OtraEmocion inherits Emocion {
  override method condicionAdicional() =  
    cantidadEventos > intensidad
}

class Evento{
  var property impacto 
  var property descripcion
}