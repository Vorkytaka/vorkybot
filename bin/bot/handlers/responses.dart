import 'dart:math';

final class PGameResponses {
  static final _random = Random();

  PGameResponses._();

  static String alreadyPlayedToday(String? username) {
    final variantsWithName = [
      'Пидор дня уже нвйдет! Это $username.\nПопробуйте завтра.',
      'Пидор дня уже определен! Очевидно это был $username.\nНапиши завтра.',
      'Отъебись, сука ты безмозглая, сегодня пидор дня уже известен! Это $username.\nПопробуй завтра, блять.',
      'Пидор дня уже назначен на должность! Это $username.\nНе пиши мне до завтра, сука.',
    ];

    final variantsWithoutName = [
      'Пидор дня уже выбран! Попробуйте завтра.',
      'Пидор дня уже определен! Попробуйте завтра.',
      'Сегодня пидор дня уже известен! Попробуйте завтра.',
      'Пидор дня уже назначен! Попробуйте завтра.',
    ];

    if (username != null && username.isNotEmpty) {
      return variantsWithName[_random.nextInt(variantsWithName.length)];
    } else {
      return variantsWithoutName[_random.nextInt(variantsWithoutName.length)];
    }
  }

  static String noRegisteredUsers() {
    return 'В этом чате нет смельчаков.\nЕсли не боишься, что все узнают какой ты пидор, то регистрируйся с помощью команды /register.\nИначе, блять, иди нахуй!';
  }

  static String groupOnly() {
    return 'Нахуй ты регистрируешься в личке? Эта команда доступна только в групповых чатах, ебанный ты пидор!';
  }

  static String registrationSuccess() {
    const variants = [
      'Что ж, теперь ты участвуешь в поиске пидора дня.\nЕсли ты не пидор, то можешь спать спокойно, а если пидор, то готовься к позору!',
      'Ты успешно зарегистрирован для игры в этом чате.\nТеперь жди, когда тебя назовут пидором дня!',
      'Поздравляю, блять, ты теперь в команде поиска пидора дня!',
    ];

    return variants[_random.nextInt(variants.length)];
  }

  static String alreadyRegistered() {
    const variants = [
      'Ты уже зарегистрирован для игры в этом чате.\nНе будь пидором, не регистрируйся дважды!',
      'Ты уже в команде поиска пидора дня.\nНе надо повторяться, ебаный ты пидор!',
      'Ты уже зарегистрирован, не надо повторять одно и то же, блять!',
      'Да, мы уже знаем, что ты пидор, не надо повторяться!',
      'Иди нахуй',
    ];

    return variants[_random.nextInt(variants.length)];
  }

  static String noPHere() {
    final variants = [
      'Кажется, здесь нет ни одного пидора!',
      'Ну и ну, в этом чате нет пидоров!',
      'Похоже, что в этом чате нет пидоров. Или они просто хорошо скрываются.',
    ];

    return variants[_random.nextInt(variants.length)];
  }

  static List<String> searching(String name) {
    final responses = _searching(name);
    final randomIndex = _random.nextInt(responses.length);
    return responses[randomIndex];
  }

  static List<List<String>> _searching(String name) => [
        [
          '📡 Активирую систему определения пидора... 📡',
          '🔍 Пидор определяется... 🔍',
          '🧑 Анализирую участников чата... 🧑‍🔬',
          '👀 Проверяю ваши переписки... 👀',
          '🏅 Пидор найден! Определенно это $name! 🏅',
        ],
        [
          'Совершенно очевидно, что пидор в этом чате - $name!',
        ],
        [
          'Отправляю сигнал в космос... 🌌',
          'Ожидаю ответа от инопланетян... 👽',
          'Вселенная подтверждает: пидор дня - $name! 🌠',
        ],
        [
          'Пидор дня найден! Это $name, блять!',
          'Пидор дня - $name, не спорь со мной, сука!',
          'Пидор дня - $name, и это не обсуждается!',
        ],
        [
          '$name ПИДОР ДНЯ! 🏆',
          '$name ПИДОР ДНЯ! 🏆',
          '$name ПИДОР ДНЯ! 🏆',
          'А теперь все вместе!',
          '$name ПИДОР ДНЯ! 🏆',
          '$name ПИДОР ДНЯ! 🏆',
          '$name ПИДОР ДНЯ! 🏆',
        ],
        [
          'Не нужно быть Шерлоком Холмсом, чтобы понять, что пидор дня - $name!',
        ],
        [
          'Хьюстон, кажется, у нас пидор! 🚁',
          'База ответьте! 📡',
          'Вас понял! 🫡',
          'Пидор дня - $name! 🥰',
        ],
      ];

  static String error() {
    const variants = [
      'Произошла ошибка при выборе пидора дня. Попробуйте еще раз позже.',
      'Какая-то хуйня случилась, не могу найти пидора дня. Попробуй еще раз.',
      'Система выбора пидора дня дала сбой. Попробуйте снова через некоторое время.',
      'Ошибка в системе поиска пидоров! Попробуй запустить поиск еще раз.',
    ];

    return variants[_random.nextInt(variants.length)];
  }

  static String playersListTitle(int count) {
    final variants = [
      'Список смельчаков в этом чате:',
      'Участники игры в этом чате:',
      'Зарегистрированные игроки:',
      'Кто играет в этом чате:',
    ];

    return variants[_random.nextInt(variants.length)];
  }

  static String noPlayersRegistered() {
    final variants = [
      'В этом чате пока никто не зарегистрирован для игры.\nИспользуйте /register чтобы присоединиться!',
      'Нет ни одного смельчака в этом чате!\nРегистрируйтесь с помощью /register, если не боитесь!',
      'Список игроков пуст.\nИспользуйте команду /register для регистрации.',
      'Здесь пока никого нет.\nНе будь пидором, регистрируйся первым с помощью /register!',
    ];

    return variants[_random.nextInt(variants.length)];
  }
}
