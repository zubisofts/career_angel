import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_path/domain/models/career.dart';
import 'package:career_path/presentation/views/screens/career/career_detail_screen.dart';
import 'package:flutter/material.dart';

class CareerItem extends StatelessWidget {
  final Career career;

  const CareerItem({Key? key, required this.career}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Hero(
        tag: career.id,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CareerDetailScreen(career: career),
              ));
            },
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: career.imageUrl,
                      fit: BoxFit.cover,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                    )),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(1.0),
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.1),
                        ],
                      ),
                    borderRadius:
                        const BorderRadius.only(bottomLeft:Radius.circular(8.0),bottomRight:Radius.circular(8.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(career.title,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22),),
                      const SizedBox(height: 8,),
                      Text(career.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
