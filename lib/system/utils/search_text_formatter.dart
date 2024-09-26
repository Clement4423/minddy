class SearchTextFormatter {

  static String format(String input) {
    return _removeAccents(input.toLowerCase().trim());
  }

  static String _removeAccents(String input) {
    const accents = 'áàâäãåčćçďéèêëěíìîïĺľńňóòôöõøřšśťúùûüýÿžźżÁÀÂÄÃÅČĆÇĎÉÈÊËĚÍÌÎÏĹĽŃŇÓÒÔÖÕØŘŠŚŤÚÙÛÜÝŸŽŹŻ';
    const withoutAccents = 'aaaaaaccceeeeeiiiillnnoooooorrsstuuuuyyzzzaaaaaaccceeeeeiiiillnnoooooorrsstuuuuyyzzz';
    
    String result = '';
    for (int i = 0; i < input.length; i++) {
      int index = accents.indexOf(input[i]);
      if (index != -1) {
        result += withoutAccents[index];
      } else {
        result += input[i];
      }
    }
    return result;
  }
}