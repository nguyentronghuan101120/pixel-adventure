enum EnvironmentType {
  platform("platform"),
  block('block');

  final String value;

  const EnvironmentType(this.value);
}

enum EnvironmentPlatformEnum {
  oneway("oneway");

  final String value;

  const EnvironmentPlatformEnum(this.value);
}

enum EnvironmentBlockEnum {
  ground('ground'),
  boundary('boundary'),
  solid("solid");

  final String value;

  const EnvironmentBlockEnum(this.value);
}
