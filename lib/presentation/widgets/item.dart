import 'package:flutter/material.dart';
import 'package:lastbloc/constants/strings.dart';
import 'package:lastbloc/data/models/charcter_model.dart';

class Item extends StatelessWidget {
  final CharactersModel character;

  const Item({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, charactersdetailsScreen,arguments: character);
      },
      child: Column(
        children: [
          Hero(tag:character.id! ,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(2),
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: character.image!.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      placeholder: "assets/images/Loading_image.gif",
                      image: character.image!,
                      fit: BoxFit.cover,
                      height: 170,
                      width: double.infinity,
                    )
                  : Image.asset(
                      "assets/images/nophoto.jpg",
                      fit: BoxFit.cover,
                      height: 170,
                      width: double.infinity,
                    ),
            ),
          ),
          Container(
            height: 25,
            decoration: const BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(12),
                bottomEnd: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            child: Text(
              character.name ?? 'Unknown',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
