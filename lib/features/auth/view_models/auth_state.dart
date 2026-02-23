class AuthState {
  final bool loading;
  final String? error;

  const AuthState({this.loading = false, this.error});

  AuthState copyWith({bool? loading, String? error}) {
    return AuthState(
      loading: loading ?? this.loading,
      error: error,
    );
  }
}