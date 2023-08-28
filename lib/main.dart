import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/siri_wave_example.dart';
import 'package:siri_wave/siri_wave.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Rive Animation',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.indigoAccent,
          textTheme: const TextTheme(
            bodyText2: TextStyle(fontSize: 32),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 32),
              minimumSize: const Size(250, 56),
            ),
          ),
        ),
        home: const HomePage(),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Rive Animation'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Simple Animation'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) =>  SimpleAnimationStateView(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Dancing Mascot'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const StateMachineMuscot(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
}

class SimpleAnimationStateView extends StatefulWidget {
  const SimpleAnimationStateView({Key? key}) : super(key: key);

  @override
  State<SimpleAnimationStateView> createState() => _SimpleAnimationStateViewState();
}

class _SimpleAnimationStateViewState extends State<SimpleAnimationStateView> {

  bool stopPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SimpleAnimation(stopPressed),

      floatingActionButton: FloatingActionButton(
        child: Text(stopPressed ?'Start' : 'Stop'),
        onPressed: (){
          setState(() {
            if (stopPressed == false) {
              this.stopPressed = true;
            } else {
              this.stopPressed = false;
            }
          });
        },
      ),
    );
  }
}

class CustomSiriWave extends StatelessWidget {
  const CustomSiriWave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = SiriWaveController();
    _controller.setSpeed(0);
    return    SiriWave(
      controller: _controller,
      options: SiriWaveOptions(
        height:  500 ,
        showSupportBar: false,
        width: 600,
      ),
      style:  SiriWaveStyle.ios_9,
    );
  }
}



class SimpleAnimation extends StatefulWidget {
  bool hasStop;
  SimpleAnimation(this.hasStop,{Key? key}) : super(key: key);

  @override
  State<SimpleAnimation> createState() => _SimpleAnimationState();
}


class _SimpleAnimationState extends State<SimpleAnimation> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title:  Text('Rive Animation').animate().shake(),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,//widget.hasStop ? Colors.white : Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Container(
                  child: Text('Bro'),
                ),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .then(delay: 1600.milliseconds)
                  .scaleXY(end: 3.1, curve: Curves.easeInOutCubic)
      .tint(color: Colors.red, end: 0.6)
              .rotate(curve: Curves.elasticInOut, duration: 1.seconds),
              Image.asset(
                'assets/doctor_avatar_image.jpg',
                fit: BoxFit.fill,
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .then(delay: 600.milliseconds)
                  .scaleXY(end: 1.1, curve: Curves.easeInOutCubic),
              // CustomSiriWave(),
              // Expanded(
              //   child: RiveAnimation.network(
              //     'https://public.rive.app/community/runtime-files/5665-11085-green-bubble.riv',
              //     fit: BoxFit.fill,
              //   ),
              // ),
              Text("Hello", style: TextStyle(color: Colors.white),).animate()
                  .fadeIn(duration: 600.ms)
                  .then(delay: 200.ms) // baseline=800ms
                  .slide(),
              Text("Before", style: TextStyle(color: Colors.white)).animate()
                  .swap(duration: 900.ms, builder: (_, __) => Text("After",style: TextStyle(color: Colors.white))),
             this.widget.hasStop
                 ? Expanded(
               child: ScaleTransition(
                 scale: CurvedAnimation(
                   parent: AnimationController(
                     vsync: this,
                     duration: Duration(milliseconds: 1500),
                   )..forward(),
                   curve: Curves.easeInOut,
                 ),
                 child: Expanded(
                   child: CustomSiriWave(),
                 ),
               ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                   .then(delay: 1600.milliseconds)
                   .scaleXY(end: 1.1, curve: Curves.easeInOut)
                  // .tint(color: Colors.blue, end: 0.6)
                   .rotate( duration: 10.seconds),
             ) : Expanded(
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: AnimationController(
                      vsync: this,
                      duration: Duration(milliseconds: 1500),
                    )..forward(),
                    curve: Curves.easeInOut,
                  ),
                  child: RiveAnimation.asset(
                    'assets/loader',
                    fit: BoxFit.fill,
                  )
                  //     .animate(onPlay: (controller) => controller.repeat(reverse: true))
                  //     .then(delay: 1600.milliseconds)
                  //     .scaleXY(end: 1.1, curve: Curves.easeInOut)
                  // // .tint(color: Colors.blue, end: 0.6)
                  //     .rotate( duration: 10.seconds),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 1200.milliseconds),
        ),
      );
}

class StateMachineMuscot extends StatefulWidget {
  const StateMachineMuscot({Key? key}) : super(key: key);

  @override
  _StateMachineMuscotState createState() => _StateMachineMuscotState();
}

class _StateMachineMuscotState extends State<StateMachineMuscot> {
  Artboard? riveArtboard;
  SMIBool? isDance;
  SMITrigger? isLookUp;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/dash_flutter_muscot.riv').then(
      (data) async {
        try {
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;
          var controller =
              StateMachineController.fromArtboard(artboard, 'birb');
          if (controller != null) {
            artboard.addController(controller);
            isDance = controller.findSMI('dance');
            isLookUp = controller.findSMI('look up');
          }
          setState(() => riveArtboard = artboard);
        } catch (e) {
          print(e);
        }
      },
    );
  }

  void toggleDance(bool newValue) {
    setState(() => isDance!.value = newValue);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Rive Animation'),
          centerTitle: true,
        ),
        body: riveArtboard == null
            ? const SizedBox()
            : Column(
                children: [
                  Expanded(
                    child: Rive(
                      artboard: riveArtboard!,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Dance'),
                      Switch(
                        value: isDance!.value,
                        onChanged: (value) => toggleDance(value),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    child: const Text('Look up'),
                    onPressed: () => isLookUp?.value = true,
                  ),
                  const SizedBox(height: 12),
                ],
              ),
      );
}
