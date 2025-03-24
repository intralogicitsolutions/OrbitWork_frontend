import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/upload_file_controller.dart';
import 'package:orbitwork/repository/api/api_constants.dart';
import '../global/tokenStorage.dart';
import '../models/attachment_model.dart';
import '../models/job_proposal_model.dart';
import '../models/submit_proposal_models.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import '../models/upload_file_model.dart';

class SubmitProposalController extends GetxController {
  final UploadFileController uploadFileController = Get.put(UploadFileController());
  final isDescriptionExpanded = false.obs;
 final proposal = Rx<SubmitProposalModel?>(null);
  final jobProposal = Rx<JobProposal?>(null);
  // final jobProposal = JobProposal().obs;
  RxBool isLoading = true.obs;
  var selectedDuration = 'Select a duration'.obs;

  final jobProposalId = ''.obs;
  final bidAmount = 0.0.obs;
  final serviceFeePercentage = 0.10;
  final coverLetter = ''.obs;
  final attachments = <UploadFile>[].obs;
  final profileHighlights = <ProfileHighlightModel>[].obs;
  final maxAttachments = 5;
  final maxFileSize = 25 * 1024 * 1024;
  final showInfoCard = true.obs;
  final highlightItems = <HighlightItemModel>[].obs;
  TextEditingController bidController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    bidController.text = jobProposal.value?.amount?.toStringAsFixed(2) ?? '0.00';
    bidController.addListener(() {
      double bid = double.tryParse(bidController.text) ?? 0.0;
      updateBid(bid);
    });
    loadProposalData();
    getJobProposals();
    print('jobProposalId ====> ${jobProposalId.value}');
   // if (jobProposalId.value.isNotEmpty) {
      getJobProposal(jobProposalId.value);
    //}
    highlightItems.addAll([
      HighlightItemModel(
        id: '1',
        title: 'Add an Orbitwork job',
        icon: '💼',
      ),
      HighlightItemModel(
        id: '2',
        title: 'Add a portfolio project',
        icon: '🎨',
      ),
      HighlightItemModel(
        id: '3',
        title: 'You don\'t have any certificates.',
        icon: '🏅',
        isEnabled: false,
      ),
    ]);
  }


  void dismissInfoCard() {
    showInfoCard.value = false;
  }

  void loadProposalData() async {
    await Future.delayed(Duration(seconds: 2));
    proposal.value = SubmitProposalModel(
      requiredConnects: 14,
      remainingConnects: 112,
      jobTitle: '[${250}] Attachments: PDF preview loads with delay, the grey line shown first #55671 - Expensify',
      category: 'Mobile App Development',
      postedDate: 'Jan 27, 2025',
      description: 'Expensify is a team of generalists developing today\'s leading expense management tool. Maintaining our reputation as an innovative leader in the world of finance requires an incredibly reliable and secure system for processing financial transactions. Accordingly, we primarily leverage time-tested...',
    // budget: 250.0,
    //   bid: 250.0,
    //   serviceFee: 0.0,
    //   finalAmount: 0.0,
    //   duration: '',
    //   coverLetter: '',
    );
    isLoading.value = false; // Loading complete
  }

  void updateBidAmount(double amount) {
    bidAmount.value = amount;
  }

  void updateBid(double bid) {
    //double bidAmount = double.tryParse(value) ?? 0.0;
    // double bidAmount = value;
    print('bidAmount ==> ${bid}');
    jobProposal.update((val) {
      val?.amount = bid;
      val?.serviceFee = bid *  0.10;
      val?.finalAmount = (bid ?? 0) - (val.serviceFee ?? 0);
    });
  }

  void updateDuration(String value) {
    jobProposal.update((val) {
      val?.duration = value;
    });
  }

  void updateCoverLetter(String value) {
    jobProposal.update((val) {
      val?.coverLetter = value;
    });
  }

  void toggleDescriptionExpansion() {
    isDescriptionExpanded.value = !isDescriptionExpanded.value;
  }

  Future<void> pickFile() async {
    const allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx', 'mp3', 'mp4'];

    if (attachments.length >= maxAttachments) {
      Get.snackbar('Error', 'Maximum 5 files allowed', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final remainingSlots = maxAttachments - attachments.length;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: false,
      type: FileType.custom, // Specify allowed file types
      allowedExtensions: allowedExtensions,
    );

    if (result != null) {
      final filesToAdd = result.files.take(remainingSlots);

      for (PlatformFile file in filesToAdd) {
        final fileExtension = file.name.split('.').last.toLowerCase();
        if (!allowedExtensions.contains(fileExtension)) {
          Get.snackbar('Error', 'Invalid file type: ${file.name}', snackPosition: SnackPosition.BOTTOM);
          continue;
        }

        if (file.size > maxFileSize) {
          Get.snackbar('Error', 'File size must be under 25MB', snackPosition: SnackPosition.BOTTOM);
          continue;
        }

        File selectedFile = File(file.path!);
        UploadFile? uploadedFile = await uploadFileController.uploadFile(selectedFile);

        if (uploadedFile != null) {
          attachments.add(uploadedFile);
        }
        //
        // attachments.add(UploadFile(
        //   name: file.name,
        //   url: file.path ?? '',
        //   size: file.size / (1024 * 1024), fileType: '', // Convert to MB
        // ));
      }

      if (attachments.length >= maxAttachments) {
        Get.snackbar('Info', 'Maximum file limit (5) reached', snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  void removeAttachment(int index) {
    attachments.removeAt(index);
  }


  void addProfileHighlight(ProfileHighlightModel highlight) {
    if (profileHighlights.length < 4) {
      profileHighlights.add(highlight);
    }
  }

  void removeProfileHighlight(String id) {
    profileHighlights.removeWhere((element) => element.id == id);
  }

  Future<void> submitProposal(String jobId) async {
    isLoading.value = true;
    String? token = await TokenStorage.getToken();

    try {
      final request = http.MultipartRequest("POST", Uri.parse(ApiConstants.CREATE_JOB_PROPOSAL));
      request.headers['Authorization'] = '$token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['job_id'] = jobId;
      request.fields['amount'] = jobProposal.value?.amount?.toStringAsFixed(2) ?? '0.00';
      request.fields['duration'] = selectedDuration.value;
      request.fields['cover_letter'] = coverLetter.value;

      for (var attachment in attachments) {
        if (attachment.url != null && attachment.url!.startsWith('http')) {

          File tempFile = await downloadFile(attachment.url!);


          final mimeType = lookupMimeType(tempFile.path) ?? 'application/octet-stream';
          request.files.add(await http.MultipartFile.fromPath(
            'files',
            tempFile.path,
            contentType: MediaType.parse(mimeType),
          ));
        } else if (attachment.url != null) {
          final mimeType = lookupMimeType(attachment.url!) ?? 'application/octet-stream';
          request.files.add(await http.MultipartFile.fromPath(
            'files',
            attachment.url!,
            contentType: MediaType.parse(mimeType),
          ));
        } else {
          Get.snackbar('Warning', 'Skipping an invalid attachment');
        }
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("Response Status: ${response.statusCode}");
      print("Response Body: $responseBody");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(responseBody);
        jobProposalId.value = responseData['_id'];
        Get.snackbar('Success', 'Proposal submitted successfully', snackPosition: SnackPosition.BOTTOM);
        getJobProposal(jobProposalId.value);
      } else {
        Get.snackbar('Error', 'Failed to submit proposal: ${jsonDecode(responseBody)}', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e', snackPosition: SnackPosition.BOTTOM);
      print('Error => ${e}');
    } finally {
      isLoading.value = false;
    }
  }


  Future<File> downloadFile(String url) async {
    final response = await http.get(Uri.parse(url));
    final tempDir = await getTemporaryDirectory(); // Get temp directory
    final filePath = '${tempDir.path}/${url.split('/').last}'; // Create file path

    File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes); // Save file to local storage

    return file; // Return the local file path
  }




  Future<void> getJobProposal(String jobProposalId) async {
    String? token = await TokenStorage.getToken(); // Replace with your token retrieval method
    String url = "${ApiConstants.GET_JOB_PROPOSAL_DETAIL}67dba20cd0424c17e94cb37b";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "$token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Job Proposal: ${data['body']}");
        jobProposal.value = JobProposal.fromJson(data);
        print('job proposal value ::: ${jobProposal.value?.amount}');
        // jobProposal.value = JobProposal(
        //   userId: data['user_id'],
        //   jobId: data['job_id'],
        //   amount: data['amount'].toDouble(),
        //   attachmentIds: List<String>.from(data['attechment_id'] ?? []),
        //   serviceFee: data['serviceFee'].toDouble(),
        //   finalAmount: data['finalAmount'].toDouble(),
        //   duration: data['duration'],
        //   coverLetter: data['coverLetter'],
        // );

      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error fetching job proposal: $e");
    }
  }

  Future<void> updateProposal() async {
   isLoading.value = true;
    String? token = await TokenStorage.getToken();

    try {
      final request = http.MultipartRequest("PUT", Uri.parse("${ApiConstants.UPDATE_JOB_PROPOSAL}67dba20cd0424c17e94cb37b"));
      request.headers['Authorization'] = '$token';
      request.fields['amount'] = jobProposal.value?.amount?.toStringAsFixed(2) ?? '0.00';
      request.fields['duration'] = selectedDuration.value;
      request.fields['cover_letter'] = coverLetter.value;

      for (var attachment in attachments) {
        final mimeType = lookupMimeType(attachment.url??'') ?? 'application/octet-stream';
        request.files.add(await http.MultipartFile.fromPath(
          'files',
          attachment.url??'',
          contentType: MediaType.parse(mimeType),
        ));
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Proposal updated successfully', snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'Failed to update proposal: ${jsonDecode(responseBody)}', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e', snackPosition: SnackPosition.BOTTOM);
    } finally {
     isLoading.value = false;
    }
  }

  Future<void> getJobProposals() async {
    String? token = await TokenStorage.getToken();

    try {
      final response = await http.get(
        Uri.parse(ApiConstants.GET_JOB_PROPOSAL),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$token", // Authorization Header
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['success'] == 1) {
          List<dynamic> jobProposals = responseData['body'];
          for (var proposal in jobProposals) {
            // print("Job ID: ${proposal['job_id']}");
            // print("Amount: ${proposal['amount']}");
            // print("Cover Letter: ${proposal['cover_letter']}");
            // print("_id: ${proposal['_id']}");
            jobProposalId.value = proposal['_id'];

            // Handling attachments
            // if (proposal['attechmentDetails'] != null) {
            //   for (var attachment in proposal['attechmentDetails']) {
            //     print("Attachment Name: ${attachment['name']}");
            //     print("Attachment URL: ${attachment['url']}");
            //   }
            // }

            //print("=============================");
          }
        } else {
          print("API Error: ${responseData['msg']}");
        }
      } else {
        print("HTTP Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching job proposals: $error");
    }
  }

  void updateDurations(String value) {
    selectedDuration.value = value;
    Get.back(); // Close BottomSheet after selection
  }
}
