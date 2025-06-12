import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../client_profile_controller/consultation_controller.dart';
import '../client_profile_model/consultation_project_model.dart';
import '../widgets/hexagon_clipper.dart';

class PopularSubcategories extends StatelessWidget{
  final String name;
  final ConsultationController controller = ConsultationController();

   PopularSubcategories({Key? key, required this.name,});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              _buildTopProjects(),
              SizedBox(height: 16,),
              Text(
                'All ${name} projects',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16,),
              _buildPeopleViewed(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(){
    return  Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 12),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
        //  color: Colors.grey[100],
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: TextField(
          onChanged: (value) {

          },
          decoration: InputDecoration(
            hintText: 'Search projects',
            hintStyle: TextStyle(color: Colors.grey[500]),
            prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
    );
  }

  Widget _buildTopProjects(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Top projects you may like', style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500
        ),),
        Text('These projects are highly rated by other clients'),
        SizedBox(height: 16,),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            // shrinkWrap: true, // Important
            // physics: NeverScrollableScrollPhysics(), // Prevent nested scrolling
            itemCount: controller.serviceProviders.length,
            itemBuilder: (context, index) {
              return _buildProjectCard(controller.serviceProviders[index]);
            },
          ),
        ),
        SizedBox(height: 18,),
        Row(
          children: [
            Text('View All Projects', style: TextStyle(
              fontSize: 16,
              color: Get.theme.primaryColor,
              decoration: TextDecoration.underline,
            ),),
            SizedBox(width: 4,),
            Icon(Icons.arrow_forward_ios, size: 16,)
          ],
        )
      ],
    );
  }

  Widget _buildPeopleViewed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          // padding: const EdgeInsets.symmetric(horizontal: 24),
          shrinkWrap: true, // Important
          physics: NeverScrollableScrollPhysics(), // Prevent nested scrolling
          itemCount: controller.serviceProviders.length,
          itemBuilder: (context, index) {
            return _buildServiceProviderCard(controller.serviceProviders[index]);
          },
        ),
      ],
    );
  }

  Widget _buildServiceProviderCard(ServiceProvider provider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
     // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service image
              Container(
                height: 100,
                width: 120,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  provider.imageUrl,
                  height: 80,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0,right: 16.0,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              provider.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          Obx(() {
                            return GestureDetector(
                              onTap: () => provider.isSaved.value = !provider.isSaved.value,
                              child: Icon(
                                provider.isSaved.value  ? Icons.favorite :  Icons.favorite_border,
                                size: 20,
                              ),
                            );
                          }
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Text(
                        '${provider.price}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          //const SizedBox(height: 12),
          Divider(height: 1,),

          // Profile section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Profile image
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: provider.name.contains('Steve') ? Colors.grey[400] :
                      provider.name.contains('Mariusz') ? Colors.orange[300] :
                      Colors.grey[600],
                      shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Text(
                      provider.name.split(' ').map((e) => e[0]).join(''),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        ClipPath(
                          // clipper: HexagonClipper(),
                          clipper: HexagonClipper(cornerRadius: 4.0),
                          child: Container(
                            // padding: EdgeInsets.all(4),
                            // decoration: BoxDecoration(
                              width: 25,
                              height: 25,
                              color: provider.isTopRatedPlus  ? Colors.pink.shade300 : Colors.blue.shade700,
                              alignment: Alignment.center,
                              //   shape: BoxShape.circle,
                              // ),
                              child: Icon(
                                Icons.star_border,
                                color: Colors.white,
                                size: 16,
                              )),
                        ),
                        SizedBox(width: 8),
                        Text(
                          provider.badge,
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                // Rating
                const Icon(
                  Icons.star,
                  size: 16,
                  color: Colors.amber,
                ),
                const SizedBox(width: 4),
                Text(
                  '${provider.rating} (${provider.reviews})',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildProjectCard(ServiceProvider provider){
    return Container(
      width: 250,
     // margin: const EdgeInsets.only(bottom: 16),
     margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                width: Get.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  provider.imageUrl,
                  height: 120,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 2)
                    ),
                      child: Icon(Icons.favorite_border,color: Get.theme.primaryColor,size: 16,)),),

              Positioned(
                top: 5,
                left: 5,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue,)
                    ),
                    child: Text('Orbitwork Picks', style: TextStyle(fontSize: 12, color: Colors.blue),)),)
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Text(provider.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),),
          ),
          Row(
            children: [
              Icon(Icons.av_timer_outlined),
              SizedBox(width: 8.0,),
              Text('1 day delivery', style: TextStyle(color: Colors.grey),),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  '${provider.price}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 1,),
          // Profile section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Profile image
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: provider.name.contains('Steve') ? Colors.grey[400] :
                      provider.name.contains('Mariusz') ? Colors.orange[300] :
                      Colors.grey[600],
                      shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Text(
                      provider.name.split(' ').map((e) => e[0]).join(''),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          provider.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                       SizedBox(width: 4,),

                        const Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${provider.rating} (${provider.reviews})',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        ClipPath(
                          // clipper: HexagonClipper(),
                          clipper: HexagonClipper(cornerRadius: 4.0),
                          child: Container(
                            // padding: EdgeInsets.all(4),
                            // decoration: BoxDecoration(
                              width: 25,
                              height: 25,
                              color: provider.isTopRatedPlus  ? Colors.pink.shade300 : Colors.blue.shade700,
                              alignment: Alignment.center,
                              //   shape: BoxShape.circle,
                              // ),
                              child: Icon(
                                Icons.star_border,
                                color: Colors.white,
                                size: 16,
                              )),
                        ),
                        SizedBox(width: 8),
                        Text(
                          provider.badge,
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}