class QR_Code {
  //OnLine
  String chave_acesso;
  String versao_qrcode;
  String tipo_ambiente; // 1-Produção; 2 - Homologação

  String dia_data_emissao; // \
  String valor_total_nfce; //  > Contingência
  String digVal; //.......... /

  String identificador_csc;
  String codigo_hash;

  QR_Code({
    this.chave_acesso,
    this.versao_qrcode,
    this.tipo_ambiente, // 1-Produção; 2 - Homologação

    this.dia_data_emissao, // \
    this.valor_total_nfce, //  > Contingência
    this.digVal, //.......... /

    this.identificador_csc,
    this.codigo_hash,
  });

  // ignore: non_constant_identifier_names
  QR_Code getFromURL(String _url) {
    int posInic = _url.indexOf("=") + 1;

    String campos = _url.substring(posInic);

    List pedaco = campos.split('|').toList();

    if (pedaco[2] != "1") {
      return null;
    }

    bool emProducao = true;
    if (pedaco[0].toString().substring(34, 2) != "01") {
      emProducao = false;
    }

    return QR_Code(
      chave_acesso: pedaco[0],
      versao_qrcode: pedaco[1],
      tipo_ambiente: pedaco[2], // 1-Produção; 2 - Homologação

      dia_data_emissao: emProducao == false ? pedaco[3] : "", // \
      valor_total_nfce: emProducao == false
          ? pedaco[4]
          : "", //  > Contingência, posição 34[2] = 01-Nomal
      digVal: emProducao == false ? pedaco[5] : "", //.......... /

      identificador_csc: emProducao == true ? pedaco[3] : pedaco[6],
      codigo_hash: emProducao == true ? pedaco[4] : pedaco[7],
    );
  }
}
