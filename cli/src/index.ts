import yargs from 'yargs';
import {streamWrite, streamEnd,chomp, chunksToLinesAsync, onExit} from '@rauschma/stringio';


const {spawn} = require('child_process');

async function main() {
  const sink = spawn('amplify', ['init']); 

  sink.stdout.on('data', function(data:string){
    
    if(data.includes('Enter a name for the project')) {
      sink.stdin.write('adama\n');
    }
    if(data.includes('Choose your default editor')) {
      sink.stdin.write('\u001b[B');
      sink.stdin.write('\n');
    }
    if(data.includes('Choose the type of app that')) {
      sink.stdin.write('\u001b[B');
      sink.stdin.write('\n');
    }
    console.log('LINE: '+data);
  });
}
main();
