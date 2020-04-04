import React from 'react'
import wweb from 'wweb'
import axios from 'axios'
import { List, Image, Container, Grid, Button, Icon } from 'semantic-ui-react'

class Results extends React.PureComponent {
    constructor() {
        super()

        this.state = {
            isLoading: false,
            value: null,
            results: null,
            final: null
        }

        this.addToSpotify = this.addToSpotify.bind(this)
        this.createPlaylist = this.createPlaylist.bind(this)
    }

    async createPlaylist() {
        const auth = wweb.cookie.get('auth')
        const query= wweb.search.get('query')
        const original_song_name = atob(query)
        const tracks = this.props.results.map((e) => {
            return {uri: e.uri}
        })
        try {
            await axios.post('/spotify/create_playlist', {auth, tracks, original_song_name})
            this.completion(true)
        } catch(e) {
            this.completion(false)
        }
    }

    completion(bool) {
        // Modal something here indicating done
    }

    addToSpotify() {
        const query = wweb.search.get('query')
        const params = `scrollbars=yes,resizable=yes,status=yes,location=yes,toolbar=no,menubar=no,left=-1000,top=-1000`;
        let popup = window.open(`auth/spotify?q=${query}`, 'Similarly', params )
        const int = setInterval(() => {
            const q = wweb.cookie.get('query')
            if (q === query) {
                this.createPlaylist()
                popup.close()
                clearInterval(int)
                return;
            }
        }, 800)
    }

    render() {
       const { results } = this.props
        return (
            <Container>
                <Grid className={"results"}>
                    <Grid.Column width={12}>
                        <Button successs onClick={this.addToSpotify}>Add To Spotify</Button>
                    </Grid.Column>
                    <Grid.Column width={12}>
                        <div>
                            <List divided relaxed>
                                {results.map((song, idx) => {
                                    return <List.Item key={idx}>
                                        <Image avatar src={song.image_uri} />
                                        <List.Content>
                                            <List.Header as='a'>{song.title} - {song.artist}</List.Header>
                                        </List.Content>
                                    </List.Item>
                                })}
                            </List>
                        </div>
                    </Grid.Column>
                </Grid>
            </Container>
        );
    }
}

export default Results;
