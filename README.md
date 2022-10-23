# YAML CV
Этот репозиторий содержит резюме в формате [yaml-cv](https://github.com/haath/yaml-cv).

## Настройка

Установите [yq v4](https://mikefarah.gitbook.io/yq/), например:
```shell
brew install yq==
```

Установите [yaml-cv](https://github.com/haath/yaml-cv):
```shell
gem install yaml-cv
```

Для создания PDF-версии, требуется `wkhtmltopdf`:
```shell
brew install wkhtmltopdf
```

### Hooks
Для автоматической проверки корректности синтаксиса YAML, проект использует [pre-commit](https://pre-commit.com).

Требуется [установить](https://pre-commit.com/#installation) его любым удобным способом.

Например, для MacOS X:
```shell
brew install pre-commit
```

А затем инициализировать:
```shell
pre-commit install
pre-commit run --all-files
```

## Использование

### Обновление информации

Исходный код включает 2 компонента:
- [src/yamlcv.yaml](src/yamlcv.yaml)

  Шаблон резюме в формате [yaml-cv](https://github.com/haath/yaml-cv)
  Сюда добавляется актуальная информация не касающаяся технических навыков.
- [src/skills.yaml](src/skills.yaml)

  Список навыков в расширенном формате. Навык должен обязательно включать `category` и `name`, а так же любой набор дополнительных полей.

### Сборка

Запустите:
```shell
scripts/build.sh
```
