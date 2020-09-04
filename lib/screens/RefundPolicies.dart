import 'package:flutter/material.dart';

class RefundPolicies extends StatelessWidget {
  static const id = 'refunPol';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refund Policies"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        children: [
          Text(
            "RETURN, REFUND \n& CANCELLATION POLICY",
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          Text(
            "\na) In the event, that there is an error in the Services provided by us, we may refund the Entry Fee, provided the reasons are genuine and proved after investigation by WIN75.\n\nb) Please read the rules of before participating.\n\nc) We do not cancel registrations once entered, however, in case of exceptional circumstances wherein the fault may lie with the payment gateway or from Our side, We will cancel your participation on request and refund the Entry Fee to You within a reasonable amount of time.\n\nd) In case we cancel your participation in any Contest as a result of this, We  will return Your Entry Fee to You within a reasonable amount of time for You to redeem the same by playing other Contests on WIN75.\n\nUsers must use any money in their Account within 365 days. WIN75 shall have the right to directly forfeit any such unused amount after 365 (three hundred and sixty five) days.  The idle Balance amount lying in your account may be withdrawn only in exceptional circumstances, determined on a case to case basis on the sole discretion of WIN75.",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
