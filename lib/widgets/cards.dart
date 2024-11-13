import 'package:invest/imports/imports.dart';

class GradientImageContainer extends StatelessWidget {
  final String imageUrl;
  final String text;
  final double gradientOpacity;
  final Function? onTap;

  const GradientImageContainer({
    super.key,
    required this.imageUrl,
    required this.text,
    this.gradientOpacity = 0.5,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Stack(
        children: [
          // Image
          SizedBox(
            height: 300, // Set the desired height here
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
              ),
            ),
          ),

          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent, // Transparent at the top
                    Colors.black.withOpacity(
                        gradientOpacity), // Black with opacity at the bottom
                  ],
                ),
              ),
            ),
          ),

          // Text
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontSize: 10,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
