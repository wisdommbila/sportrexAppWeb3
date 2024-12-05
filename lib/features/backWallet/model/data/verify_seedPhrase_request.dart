

import 'package:equatable/equatable.dart';


class VerifySeedPhraseRequest implements EquatableMixin {
    final String? seedPhrase;

    VerifySeedPhraseRequest({
        this.seedPhrase,
    });

    VerifySeedPhraseRequest copyWith({
        String? seedPhrase,
    }) => 
        VerifySeedPhraseRequest(
            seedPhrase: seedPhrase ?? this.seedPhrase,
        );

    factory VerifySeedPhraseRequest.fromJson(Map<String, dynamic> json) => VerifySeedPhraseRequest(
        seedPhrase: json["seedPhrase"],
    );

    Map<String, dynamic> toJson() => {
        "seedPhrase": seedPhrase,
    };
    
      @override
      List<Object?> get props => [seedPhrase];
    
      @override
    
      bool? get stringify => true;
}
