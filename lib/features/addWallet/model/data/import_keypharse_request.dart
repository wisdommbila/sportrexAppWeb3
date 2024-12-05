

import 'package:equatable/equatable.dart';


class ImportKeyPharseRequest implements EquatableMixin {
    final String? seedPhrase;

    ImportKeyPharseRequest({
        this.seedPhrase,
    });

    ImportKeyPharseRequest copyWith({
        String? seedPhrase,
    }) => 
        ImportKeyPharseRequest(
            seedPhrase: seedPhrase ?? this.seedPhrase,
        );

    factory ImportKeyPharseRequest.fromJson(Map<String, dynamic> json) => ImportKeyPharseRequest(
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
