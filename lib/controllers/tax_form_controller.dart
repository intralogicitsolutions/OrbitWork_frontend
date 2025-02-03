import 'package:get/get.dart';
import 'package:orbitwork/models/tax_form_model.dart';

class TaxFormsController  extends GetxController{
  var taxForms = <TaxForm>[].obs;

  @override
  void onInit() {
    super.onInit();
    taxForms.addAll( [
      TaxForm(year: '2024', submissionDate: 'November 15', formType: 'W-8BEN'),
      TaxForm(year: '2023', submissionDate: 'December 20', formType: 'W-8BEN'),
      TaxForm(year: '2023', submissionDate: 'October 11', formType: 'W-8BEN'),
    ]);
  }

  // void loadTaxForms(){
  //   taxForms.addAll( [
  //     TaxForm(year: '2024', submissionDate: 'November 15', formType: 'W-8BEN'),
  //     TaxForm(year: '2023', submissionDate: 'December 20', formType: 'W-8BEN'),
  //     TaxForm(year: '2023', submissionDate: 'October 11', formType: 'W-8BEN'),
  //   ]);
  // }

  void viewTaxForm(TaxForm form){

  }
}