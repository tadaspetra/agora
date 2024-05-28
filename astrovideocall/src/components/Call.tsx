import {
  AgoraRTCProvider,
  LocalVideoTrack,
  RemoteUser,
  useJoin,
  useLocalCameraTrack,
  useLocalMicrophoneTrack,
  usePublish,
  useRTCClient,
  useRemoteAudioTracks,
  useRemoteUsers
} from "agora-rtc-react";
import AgoraRTC from "agora-rtc-sdk-ng";
import { useState } from "react";

function App(props: { appId: string, channelName: string }) {
  const client = useRTCClient(AgoraRTC.createClient({ codec: "vp8", mode: "rtc" }));
  const [inCall, setInCall] = useState(true);

  return (
    <div >
      {!inCall ? (
      <div className='ml-12 flex flex-col'>
        <div className='pt-10'></div>
        <button className="px-5 py-3 mt-5 text-base font-medium text-center text-white bg-gray-400 rounded-lg hover:bg-gray-500 focus:ring-4 focus:ring-blue-300 dark:focus:ring-blue-900 w-40" onClick={() => setInCall(true)}>Rejoin Call</button>
        <a className=" px-5 py-3 mt-5 text-base font-medium text-center text-white bg-blue-400 rounded-lg hover:bg-blue-500 focus:ring-4 focus:ring-blue-300 dark:focus:ring-blue-900 w-40" href='/'>Back</a>
      </div>
      ) : (
        <AgoraRTCProvider client={client}>
          <Videos channelName={props.channelName} AppID={props.appId} token={""} />
          <br /><br />
          <div className="fixed z-10 bottom-0 left-0 right-0 flex justify-center pb-4">
            <button className="px-5 py-3 text-base font-medium text-center text-white bg-red-400 rounded-lg hover:bg-red-500 focus:ring-4 focus:ring-blue-300 dark:focus:ring-blue-900 w-40" onClick={() => setInCall(false)}>End Call</button>
          </div>
        </AgoraRTCProvider>
      )}
    </div>
  );
}

function Videos(props: { channelName: string; AppID: string; token: string }) {
  const { AppID, channelName, token } = props;
  const { isLoading: isLoadingMic, localMicrophoneTrack } = useLocalMicrophoneTrack();
  const { isLoading: isLoadingCam, localCameraTrack } = useLocalCameraTrack();
  const remoteUsers = useRemoteUsers();
  const { audioTracks } = useRemoteAudioTracks(remoteUsers);

  usePublish([localMicrophoneTrack, localCameraTrack]);
  useJoin({
    appid: AppID,
    channel: channelName,
    token: token === "" ? null : token,
  });

  audioTracks.map((track) => track.play());
  const deviceLoading = isLoadingMic || isLoadingCam;
  if (deviceLoading) return <div >Loading devices...</div>;

  const numUsers = remoteUsers.length + 1; 
  let numCols;
  let numRows;
  switch (numUsers) {
    case 1:
      numCols = 1;
      numRows = 1;
      break;
    case 2:
      numCols = 2;
      numRows = 1;
      break;
    case 3:
      numCols = 2;
      numRows = 2;
      break;
    case 4:
      numCols = 2;
      numRows = 2;
      break;
    default:
      numCols = 3;
      numRows = 3;
      break;
  }

  return (
    <div className="flex flex-col justify-between w-full h-screen p-1">
      <div className={`grid grid-cols-${numCols} grid-rows-${numRows} gap-1 flex-1`}>
        <LocalVideoTrack track={localCameraTrack} play={true} className="w-full h-full" />
        {remoteUsers.map((user) => (
          <RemoteUser user={user} />
        ))}
        {/* Add empty squares to fill the grid */}
        {Array(numCols * numRows - numUsers).fill(1).map((_, i) => (
          <div key={i} className="bg-gray-200 w-full h-full"></div>
        ))}
      </div>
    </div>
  );
}


export default App;

        /* <LocalVideoTrack track={localCameraTrack} play={true} className="w-full h-full"/>
        {remoteUsers.map((user) => (
          <RemoteUser user={user} />
        ))} */