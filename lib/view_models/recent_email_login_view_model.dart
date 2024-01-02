import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_final3/repos/recent_login_email_repo.dart';

class RecentLoginEmailViewModel extends Notifier<String> {
  final RecentLoginEmailRepository _repository;
  late String _email;

  RecentLoginEmailViewModel(this._repository);

  @override
  String build() {
    _email = _repository.getRecentEmail();
    return _email;
  }

  void resetLoginEmail(String newEmail) {
    _email = newEmail;
    _repository.setRecentEmail(_email);
    state = _email;
  }
}

final recentLoginEmailProvider =
    NotifierProvider<RecentLoginEmailViewModel, String>(
  // main.dart 에서 override
  () => throw UnimplementedError(),
);
