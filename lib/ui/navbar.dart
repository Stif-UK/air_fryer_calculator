import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  String _buildVersion = "Not Determined";
  bool _celcius = true;

  @override
  void initState() {
    super.initState();
    _getBuildVersion().then((val) {
      setState(() {
        _buildVersion = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int clickCounter =0;
    //bool _celcius = true;

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(child: IconButton(
                  splashColor: Colors.transparent,
                  icon: const Icon(Icons.accessibility, size: 40.0),
                  onPressed: (){
                    print(clickCounter);
                    clickCounter++;
                    print(clickCounter);
                    if (clickCounter > 5) {
                      Get.defaultDialog(
                          title: "Open Count",
                          middleText: "nothing to show yet"
                      );
                    }
                  },

                )),

                SwitchListTile(
                  title: _celcius? const Text("Temperature: Celcius"): const Text("Temperature: Fahrenheit"),
                  activeThumbImage: ,
                  value: _celcius,
                  onChanged: (bool newValue){
                    setState(() {
                      _celcius = newValue;

                    });
                  },

                ),
                ListTile(
                  title: const Text("Privacy Policy"),
                  trailing: const Icon(Icons.privacy_tip_outlined),
                  onTap: (){
                    //Get.to(() => PrivacyPolicy());
                  },
                ),
                ListTile(
                  title: const Text("About App"),
                  trailing: const Icon(Icons.info_outline),
                  onTap: (){
                    //Get.to(() => const AboutApp());
                  },
                ),
                ListTile(
                  title: const Text("Attributions"),
                  trailing: const Icon(Icons.check_box_outlined),
                  onTap: (){
                    //Get.to(() => const Attributions());
                  },
                ),
                ListTile(
                  title: const Text("Version History"),
                  trailing: const Icon(Icons.history),
                  onTap: (){
                    //Get.to(() => const VersionHistory());
                  },
                ),
                const SizedBox(height: 100,),

              ],
            ),
          ),
          Text("App Version: $_buildVersion "),
          const SizedBox(height: 25,)
        ],
      ),
    );
  }

  Future<String> _getBuildVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;

  }
}
