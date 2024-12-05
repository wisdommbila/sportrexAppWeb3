import '../../../../core/commonLibs/common_libs.dart';

class BlogDetail extends StatelessWidget {
  const BlogDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isBusy: false,
        appBar: BaseAppBar(
          backBtnColor: $styles.colors.greyMedium,
          showLeading: true,
          centerTitle: $strings.explore,
          textColor: $styles.colors.white,
        ),
        backgroundColor: $styles.colors.primary,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 260,
                width: double.infinity,
                foregroundDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  border:
                      Border.all(color: $styles.colors.greyMedium, width: 0.5),
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xff152139).withOpacity(0),
                      const Color(0xff152139).withOpacity(0.94),
                    ],
                  ),
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://images.cnbctv18.com/wp-content/uploads/2021/05/Ether-e1647957866195-1019x573.jpg?impolicy=website&width=617&height=264"),
                  ),
                ),
              ),
              Gap(15 * $styles.scale),
              Text(
                "New York Times",
                style: $styles.text.body.copyWith(
                    color: $styles.colors.greyMedium,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400),
              ),
              Gap(5 * $styles.scale),
              Text(
                "The Biggest Dip Yet",
                style: $styles.text.body.copyWith(
                    color: $styles.colors.tertiary,
                    fontSize: 18.8.sp,
                    fontWeight: FontWeight.w600),
              ),
              Gap(5 * $styles.scale),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo. ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo.ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo.ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo.ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo.ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo.ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo.",
                style: $styles.text.body.copyWith(
                    color: $styles.colors.greyMedium,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ));
  }
}
