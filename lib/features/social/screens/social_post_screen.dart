import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/outfit/models/outfit_model.dart';
import 'package:chom_tu/features/outfit/providers/outfit_controller.dart';
import 'package:chom_tu/features/social/provider/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SocialPostScreen extends StatelessWidget {
  const SocialPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postProvider = Provider.of<PostProvider>(context, listen: false);
    late List<OutfitModel> outfitList;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kColorsWhite,
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(
            color: kColorsLightGrey,
            width: kAppbarBorderWidth
          )
        ),
        elevation: 0,
        toolbarHeight: 60,
        centerTitle: true,
        title: Text('Post', style: Theme.of(context).textTheme.headline1),
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: kColorsWhite,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsBlack),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22, top: 22),
            child: InkWell(
              onTap: (){
                if (postProvider.imagePath == '') {
                  postProvider.setPostImage(outfitList[0].outfitImg!);
                }
                Navigator.pushNamed(context, '/social_post_caption');
              },
              child: Text('Next', style: Theme.of(context).textTheme.headline5)
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: OutfitController().getAllOutfits('Newest', []),
        builder: (BuildContext context, AsyncSnapshot<List<OutfitModel>> snapshot) {
          if(snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          else if(snapshot.connectionState == ConnectionState.done) {
            outfitList = snapshot.data!;
            return postBody(context, outfitList, postProvider);
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget postBody(context, List<OutfitModel> outfitList, PostProvider postProvider) {
    return Consumer<PostProvider>(
      builder: (_, value, __) {
        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(postProvider.imagePath == '' ? outfitList[0].outfitImg! : postProvider.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ),
            Container(
              height: 60,
              color: kColorsWhite,
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Please select outfit', style: Theme.of(context).textTheme.headline2)
                ),
              )
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: outfitList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1
                ),
                itemBuilder: (BuildContext context, int index) {
                  OutfitModel outfit = outfitList[index];

                  return Padding(
                    padding: const EdgeInsets.only(left: 1, right: 1, bottom: 2),
                    child: InkWell(
                      onTap: (){
                        postProvider.setPostImage(outfit.outfitImg!);
                      },
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(outfit.outfitImg!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        child: Container(
                          color: kColorsWhite.withOpacity(postProvider.imagePath == outfit.outfitImg! || (postProvider.imagePath == '' && index == 0) ? 0.7 : 0),
                        ),
                      )
                    ),
                  );
                }
              ),
            ),
          ],
        );
      }
    );
  }
}