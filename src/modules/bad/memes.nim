include base

const
  Answers = [
    "Каеф", "Не баян (баян)", 
    "Ну держи!", "А вот и баянчики подъехали"
  ]

var groupId = ""

proc giveMemes(api: VkApi, msg: Message, groupId: string) {.async.} = 
  ## Получает случайную фотографию из постов группы с id groupId
  var pic: JsonNode
  # Пока мы не нашли картинку
  while pic.isNil():
    let 
      # Отправляем API запрос
      data = await api@wall.get(owner_id=groupId, 
                                offset=random(1984+1), count=1)
      attaches = data["items"][0].getOrDefault("attachments")
    # Если у поста есть аттачи
    if attaches != nil:
        pic = attaches[0].getOrDefault("photo")
  let 
    # ID владельца картинки
    oid = $pic["owner_id"].getNum()
    # ID самой картинки
    attachId = $pic["id"].getNum()
    # Access key может понадобиться, если группа закрытая 
    accessKey = pic["access_key"].str
    attachment = "photo$1_$2_$3" % [oid, attachId, accessKey]
  answer(random(Answers), attachment)

module "﷽", "Мемы - случайные мемы":
  startConfig:
    groupId = config["group_id"].str

  command "мемы", "мемчики", "мемасы", "мемасики", "мемас":
    usage = "мемы - случайный мем"
    await giveMemes(api, msg, groupId)