import 'package:get/get.dart';
import '../models/job_detail_model.dart';

class JobDetailsController extends GetxController {
  final JobDetailsModel jobDetails = JobDetailsModel(
    title: 'Fix clerk adding issue into a simple react app',
    description: 'I am adding clerk user management to react app (simple one, created with create-react-app). However getting issue.',
    expertise: 'Specialized profiles can help you better highlight your expertise when submitting proposals to jobs like these.',
    location: 'Worldwide',
    connects: 11,
    availableConnects: 26,
    price: 5.0,
    experienceLevel: 'Intermediate',
    projectType: 'One-time project',
    hirers: 96,
    activeHirers: 18,
    avgHourlyRate: 11.75,
    industry: 'Agriculture & Forestry',
  );
}