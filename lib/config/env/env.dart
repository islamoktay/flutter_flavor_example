enum Env {
  dev("DEV"),
  test("UTEST"),
  prod("PROD");

  const Env(this.label);
  final String label;
}

Env getEnvironment(String envText) {
  return Env.values.firstWhere(
    (e) => e.label == envText,
    orElse: () => Env.dev,
  );
}
