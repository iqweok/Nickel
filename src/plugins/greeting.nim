include base

const Greetings = ["Запущен и готов служить!", 
                   "У контакта ужасный флуд-контроль :(", 
                   "Писать ботов не так-то просто, как кажется!",
                   "Привет, странствующий путник!"]

proc greet(api: VkApi, msg: Message) {.async.} =
  let answer = random(Greetings)
  await api.answer(msg,  random(Greetings))

greet.handle("привет", "ку", "прив", "хей", "хэй", "qq")