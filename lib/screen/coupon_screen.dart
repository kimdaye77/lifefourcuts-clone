import 'package:flutter/material.dart';

class Coupon extends StatefulWidget {
  const Coupon({super.key});

  @override
  State<Coupon> createState() => _CouponState();
}

class _CouponState extends State<Coupon> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.grey,
            size: 25,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).backgroundColor,
          title: const Text(
            "쿠폰",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          child: Column(
            children: [
              _buildCoupon(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '사용 가능한 쿠폰',
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xffc19e85),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        '발급받은 쿠폰 중 사용 가능한 쿠폰만 보여집니다.',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        '쿠폰 다운로드',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _availableCoupon(),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '사용한 쿠폰',
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xffc19e85),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        '1개월 이내에 사용한 쿠폰 최대 5개만 보여집니다.',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  _usedCoupon(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoupon() {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Theme.of(context).backgroundColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
        spacing: MediaQuery.of(context).size.width * 0.01,
        runSpacing: MediaQuery.of(context).size.height * 0.005,
        children: _buildCouponItem(),
      ),
    );
  }

  List<Widget> _buildCouponItem() {
    List<Widget> coupons = [];

    for (int i = 0; i < 10; i++) {
      coupons.add(Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1.5,
          ),
          shape: BoxShape.circle,
        ),
        child: Text(
          '인생\n네컷',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'GmarketSans',
            color: Colors.grey.shade400,
          ),
        ),
      ));
    }
    return coupons;
  }

  Widget _availableCoupon() {
    return Container();
  }

  Widget _usedCoupon() {
    return Container();
  }
}
