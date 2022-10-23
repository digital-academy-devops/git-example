# YAML CV
Этот репозиторий содержит моё резюме в формате YAML.

## Настройка

Установите yq, например:
```shell
brew install yq
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
