import React from 'react'
import axios from 'axios'
import {Grid, Button} from 'semantic-ui-react'
import { List, Image } from 'semantic-ui-react'

class Results extends React.PureComponent {
    constructor() {
        super()

        this.state = {
            isLoading: false,
            value: null,
            results: null,
            final: null
        }
    }

    render() {
        console.log(this.props.results)

        return (
            <Grid className={"results"}>
                <Grid.Column width={12}>
                    <div>
                        <List divided relaxed>

                        {parsedResults.similartracks.track.map((song, idx) => {
                            return <List.Item key={idx}>
                                <Image avatar src={song.image[0]["#text"]} />
                                <List.Content>
                                    <List.Header as='a'>{song.name} - {song.artist.name}</List.Header>
                                </List.Content>
                             </List.Item>
                            })}
                        </List>
                    </div>
                </Grid.Column>
            </Grid>
        );
    }
}

export default Results;
