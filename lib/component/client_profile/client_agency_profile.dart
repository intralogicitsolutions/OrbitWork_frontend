import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orbitwork/client_profile_controller/client_agency_profile_controller.dart';
import 'package:orbitwork/comms/global/global_tooltip.dart';
import 'package:orbitwork/widgets/custom_tooltip.dart';

import '../../widgets/hexagon_clipper.dart';
import 'invite_to_job_bottomsheet.dart';

class ClientAgencyProfile extends StatelessWidget{
  final ClientAgencyProfileController controller = Get.put(ClientAgencyProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agency profile'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 130,
                      child: Stack(
                        children: [
                          Image.network('https://www.upwork.com/static/assets/AgencyNuxt/img/agency-header-banner.1192594.png',
                            height: 80,
                            width: Get.width,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 30,
                            left: 10,
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.white
                              ),
                            ),
                          ),
                          Positioned(
                            top: 35,
                            left: 10,
                            child: SvgPicture.asset(
                              'assets/icon/profile_header_logo.svg',
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('MarDesignStudio', style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500
                          ),),
                          SizedBox(height: 18,),
                          _buildOverView(),
                          SizedBox(height: 18,),
                          _buildOrbitworkActivity(),
                          SizedBox(height: 18,),
                          _buildOfficeLocation(),
                          SizedBox(height: 18,),
                          _buildCompanyInformation(),
                          SizedBox(height: 18,),
                          _buildLanguage(),
                          SizedBox(height: 18,),
                          _buildSaveAgency(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildOverView(){
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 20),
          Text(
            'Unlock the Sales Secrets of Top E-Commerce Sellers: Elevate Your Presence on Amazon, Etsy, Bol.com, eBay, TikTok Shop and Beyond!',
          ),
          SizedBox(height: 20),
          Text(
            '**Well-researched images with a High Emotional Impact that CONVERT**',
          ),
          SizedBox(height: 20),

          Obx(() {
            if (controller.isExpanded.value) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Refined Process:'),
                  SizedBox(height: 20),
                  Text('Research Phase - I delve into your niche and analyze your top 5-10 competitors.'),
                  Text('Concept Brainstorming - I generate ideas for each image through collaborative brainstorming.'),
                  Text('Design Work - I craft your captivating, high-converting images.'),
                  Text('Delivery & Review - I present my work and provide you with 7 FREE revisions for your satisfaction.'),
                  SizedBox(height: 20),
                  Text(
                    'With over 5000+ E-commerce Designs Delivered and 2000+ Satisfied Clients, I\'m Not Just a Designer — I\'m Your Amazon Marketing Ally. Let My Portfolio Speak for Itself!',
                  ),
                  Text(
                    'Seize the Opportunity to Skyrocket Your Sales. Place Your Order Today!!!',
                  ),
                  SizedBox(height: 16),
                ],
              );
            } else {
              return SizedBox.shrink(); // collapsed
            }
          }),

          Obx(() => GestureDetector(
            onTap: controller.toggleExpanded,
            child: Row(
              children: [
                Text(
                  controller.isExpanded.value ? 'Read less' : 'Read more',
                  style: TextStyle(
                    color: Get.theme.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    decorationColor: Get.theme.primaryColor
                  ),
                ),
                Icon(controller.isExpanded.value ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_up,
                color: Get.theme.primaryColor,)
              ],
            ),
          )),
          Divider(height: 40,),
          _buildBusinessManagers(),
        ],
      ),
    );
  }

  Widget _buildBusinessManagers(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Business managers', style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500
            ),),
            Obx(() {
                return IconButton(onPressed: controller.toggleBusinessExpanded,
                    icon: Icon(controller.businessExpanded.value ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_up,));
              }
            )
          ],
        ),
        SizedBox(height: 18,),
        Obx(() {
          if (controller.businessExpanded.value){
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person_outline),
                      ),
                      SizedBox(width: 14,),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mar D.', style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Get.theme.primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: Get.theme.primaryColor
                            ),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.thumb_up, size: 12,color: Colors.blue,),
                                      Flexible(child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                        child: Text('96% Job Success',
                                          //overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipPath(
                                        clipper: HexagonClipper(cornerRadius: 2.0),
                                        child: Container(
                                          // padding: EdgeInsets.all(4),
                                          // decoration: BoxDecoration(
                                            width: 14,
                                            height: 16,
                                            color: Colors.pink.shade300,
                                            alignment: Alignment.center,
                                            //   shape: BoxShape.circle,
                                            // ),
                                            child: Icon(
                                              Icons.star_border,
                                              color: Colors.white,
                                              size: 10,
                                            )),
                                      ),
                                      Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                            child: Text('Top Rated Plus',
                                              // overflow: TextOverflow.ellipsis,
                                              softWrap: true,),
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 18,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Get.theme.scaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Get.theme.primaryColor, width: 2))
                      ),
                      onPressed: () {
                        Get.bottomSheet(
                          JobInviteBottomSheet(),
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                         barrierColor: Colors.black.withOpacity(0.5),
                        );
                      }, child: Text('Invite To Job', style: TextStyle(
                    color: Get.theme.primaryColor,
                  ),))
                ],
              ),
            );
          }else {
            return SizedBox.shrink(); // collapsed
          }

          }
        )
      ],
    );
  }

  Widget _buildOrbitworkActivity(){
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Orbitwork activity', style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),),
              GlobalTooltip(content: Text('Refers to this agency\'s work on Orbitwork and is not representative of total business.')),
            ],
          ),
          SizedBox(height: 10,),
          _buildColumnData('Hourly rate', '\$34.99'),
          _buildColumnData('Total jobs', '0'),
          _buildColumnData('Member since', 'Dec 30,2024'),
        ],
      ),
    );
  }

  Widget _buildOfficeLocation(){
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Office location', style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 20,),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 14,),
              Text('Tirana, Albania'),
            ],
          ),
          SizedBox(height: 10,),
          Text('8:41 am GMT+2 Primary location', style: TextStyle(
            color: Colors.grey
          ),)
        ],
      ),
    );
  }

  Widget _buildCompanyInformation(){
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Company information', style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 12,),
          _buildColumnData('Agency size', '11-50 workers',tooltip: true, contentText: 'Agency size indicates the number of people working for an agency (employees, freelancers, subcontractors, etc.)'),
          _buildColumnData('Year founded', '2024'),
          _buildColumnData('Client focus', 'Large business \nMedium business \nVery small business \nSmall business'),
        ],
      ),
    );
  }

  Widget _buildLanguage(){
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Languages', style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 12,),
          _buildRowData('English', 'Native or Bilingual'),
          _buildRowData('Albanian', 'Native or Bilingual'),
          _buildRowData('Italian', 'Native or Bilingual'),
          _buildRowData('Spanish', 'Fluent'),
          _buildRowData('French', 'Conversational'),
          _buildRowData('German', 'Conversational'),
        ],
      ),
    );
  }

  Widget _buildSaveAgency(){
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 28, 80, 67),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/icon/save.svg',
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20,),
          Text('You & MarDesignStudio: future collaborators?', style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white
          ),),
          SizedBox(height: 16,),
          Text('Save this agency to custom lists to help you find the rightfit for current or upcoming projects. Add notes and tags to track your thoughts about potential hires.',
          style: TextStyle(color: Colors.white),),
          SizedBox(height: 16,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: Get.theme.primaryColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0
            ),
              onPressed: () {

          }, child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, color: Get.theme.primaryColor,),
              SizedBox(width: 8.0,),
              Text('Save', style: TextStyle(
                fontSize: 16, color: Get.theme.primaryColor
              ),),
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildColumnData(String title, String value, {bool? tooltip = false, String? contentText}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: TextStyle(
                color: Colors.grey.shade600
              ),),
              tooltip == true ? GlobalTooltip(content: Text(contentText!), iconSize: 14,) : SizedBox()
            ],
          ),
          Text(value, style: TextStyle(
             fontSize: 18, fontWeight: FontWeight.w500
          ),)
        ],
      ),
    );
  }

  Widget _buildRowData(String title, String value){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text('$title:', style: TextStyle(fontSize: 16),),
          Text(' $value', style: TextStyle(
            color: Colors.grey.shade600,
              fontSize: 16
          ),)
        ],
      ),
    );
  }

  Widget _buildFooter(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade300
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Get.theme.scaffoldBackgroundColor,
              shape: BoxShape.circle,
              border: Border.all(color: Get.theme.primaryColor, width: 1.5)
            ),
              child: Icon(Icons.more_horiz,color: Get.theme.primaryColor,size: 18,),
          ),
          SizedBox(width: 10,),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor,
                shape: BoxShape.circle,
                border: Border.all(color: Get.theme.primaryColor, width: 1.5)
            ),
            child: Icon(Icons.favorite_border,color: Get.theme.primaryColor,size: 18,),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Get.theme.primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
                onPressed: () {
                  Get.bottomSheet(
                    JobInviteBottomSheet(),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.black.withOpacity(0.5),
                  );
                }, child: Text('Invite To Job', style: TextStyle(
              color: Colors.white
            ),)),
          )
        ],
      ),
    );
  }

}