import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../client_profile_controller/talent_controller.dart';
import '../client_profile_model/talent_model.dart';
import '../widgets/hexagon_clipper.dart';

class RecentlyViewedPage extends StatelessWidget{
  final TalentController controller = Get.put(TalentController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRecentlyViewedSection(),
      ],
    );
  }
  Widget _buildRecentlyViewedSection() {
    return Column(
      children: [
        SizedBox(height: 16),
        Container(
          height: Get.height,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.recentlyViewed.length,
            itemBuilder: (context, index) {
              return _buildTalentCard(controller.recentlyViewed[index], true);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTalentCard(TalentModel talent, bool isCompact) {
    return GestureDetector(
      onTap: () => controller.viewTalentProfile(talent),
      child: Column(
        children: [
          Container(
            //width: isCompact ? 280 : 300,
            margin: EdgeInsets.only(right: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          radius: 25,
                          child: Icon(Icons.account_circle, color: Colors.grey,size: 28,),
                          //backgroundImage: NetworkImage(talent.profileImage),
                        ),
                        if (talent.isOnline)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            talent.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '${talent.location} | ${talent.specialization}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => controller.addToFavorites(talent.id),
                          child: Icon(Icons.favorite_border),
                        ),
                        SizedBox(width: 4), // optional tiny spacing
                        GestureDetector(
                          onTap: () => controller.addToFavorites(talent.id),
                          child: Icon(Icons.more_horiz),
                        ),
                      ],
                    )

                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      '\$${talent.hourlyRate.toStringAsFixed(2)}/hr',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.thumb_up, color: Colors.blue, size: 16,),
                    SizedBox(width: 4),
                    Text(
                      '${talent.jobSuccessRate}% Job Success',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: 16),
                    ClipPath(
                      // clipper: HexagonClipper(),
                      clipper: HexagonClipper(cornerRadius: 4.0),
                      child: Container(
                        // padding: EdgeInsets.all(4),
                        // decoration: BoxDecoration(
                          width: 25,
                          height: 25,
                          color: talent.isTopRated  ? Colors.pink.shade300 : Colors.blue.shade700,
                          alignment: Alignment.center,
                          //   shape: BoxShape.circle,
                          // ),
                          child: Icon(
                            Icons.star_border,
                            color: Colors.white,
                            size: 16,
                          )),
                    ),
                    SizedBox(width: 4),
                    Text(talent.isTopRated  ?
                    'Top Rated Plus':'Top Rated',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Obx(() {
                  final isExpanded = talent.isExpanded.value;
                  final text = talent.discription;
                  final maxLines = isExpanded ? null : 3;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text??'',
                        maxLines: maxLines,
                        overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.grey[800], height: 1.4),
                      ),
                      SizedBox(height: 4),
                      GestureDetector(
                        onTap: () => talent.isExpanded.toggle(),
                        child: Text(
                          isExpanded ? 'View Less' : 'View More',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

}