import 'dart:io';

import 'package:flutter_mailer/flutter_mailer.dart';

sendEmail(File file,String str) async {
  final MailOptions mailOptions = MailOptions(
    body: 'Je vous prie de bien vouloir trouver ci-joint, le fichier d\'inventaire du : $str',
    subject: 'Fichier d\'inventaire',
    recipients: ['diikaane@gmail.com', 'baidy@mbfconsulting-sn.com'],
    isHTML: false,
    attachments: [file.path],
  );

  FlutterMailer.send(mailOptions)
      .then((value) async => print('Email envoyé avec succes'));
}
