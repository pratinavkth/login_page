import 'package:flutter/material.dart';
import 'package:login_page/Audio/server/audio_service.dart';
import 'recording.dart';
import 'package:login_page/Audio/models/audio_model.dart';

class Audio extends StatefulWidget {
  const Audio({Key? key}) : super(key: key);

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  // @override
  late Future<List<Audios>> futreaudio;
  final AudioService audioService = AudioService();

  @override
  void initState() {
    super.initState();
    futreaudio = audioService.fetchallAudio(context: context);
    
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.05),
          child: AppBar(
            // elevation: 0.1,
            shape: const Border(bottom: BorderSide(color: Colors.grey)),
            // title: const Text('Search Notes'),
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.03),
                child: IconButton(
                    onPressed: () {},
                    icon: Image.asset("assets/logo_noteit.png")),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  // showSearch(context: context, delegate: Searchbar());
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.account_circle_outlined),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.15,
                    // left: screenWidth*0.40,right: screenWidth*0.25,bottom: screenHeight*0.2
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Recording()));
                    },
                    icon: const Icon(
                      Icons.mic,
                      size: 248,
                    ),
                  )),
            ),
            const Center(
              child: Text(
                'Audios',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<Audios>>(
                future: futreaudio,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      
                      child: Text('Error${snapshot.hasError}',
                      style: TextStyle(fontSize: 18, color: Colors.red)
                      ),
                    );
                  } else if (snapshot.hasData) {
                    List<Audios> audio = snapshot.data!;
                    print("no audio there is no issue");
                    return Container(
                      height: screenHeight * 0.3,
                      
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      
                        child:ListView.builder(
                          
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: audio.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      // textColor: Colors.black,
                                      leading: const Icon(Icons.audio_file,color: Colors.black,),
                                      title: Text(audio[index].fileName,
                                      style:const TextStyle(fontSize: 18, color: Color.fromARGB(255, 218, 39, 39)),
                                      )
                                      ,
                                      subtitle: Text(audio[index].uploadedAt),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.more_horiz),
                                        onPressed: () {},
                                      ),
                                    ),
                                  );
                                }),
                                
                    );
                    
                  } else {
                    return const Text('no audio available');
                  }
                  // return Container();
                }),
          ],
        ));
  }
}
